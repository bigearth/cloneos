defmodule Farmbot.System.Updates do
  @moduledoc """
    Check, download, apply updates
  """

  @headers ["User-Agent": "FarmbotOS"]
  @target Mix.Project.config()[:target]
  @ssl_hack [ ssl: [{:versions, [:'tlsv1.2']}] ]
  @path "/tmp/update.fw"
  require Logger
  alias Farmbot.System.FS

  # TODO(connor): THIS IS A MINOR IMPROVEMENT FROM THE LAST VERSION OF THIS FILE
  # BUT IT DEFINATELY NEEDS FURTHER REFACTORING.

  @spec mod(atom) :: atom
  defp mod(target), do: Module.concat([Farmbot, System, target, Updates])

  defp releases_url do
    {:ok, token} = Farmbot.Auth.get_token()
    token.unencoded.os_update_server
  end

  @doc """
    Checks for updates if the bot says so
  """
  def do_update_check do
    if Farmbot.BotState.get_config(:os_auto_update) do
      check_and_download_updates()
    else
      Logger.info ">> Will not do update check!"
    end
  end

  @doc """
    Checks for updates, and if there is an update, downloads, and applies it.
  """
  @spec check_and_download_updates :: :ok | {:error, term} | :no_updates
  def check_and_download_updates do
    case check_updates() do
      {:update, url} ->
        Logger.info ">> has found a new Operating System update! #{url}",
          type: :busy
        install_updates(url)
      :no_updates ->
        Logger.info ">> is already on the latest Operating System version!",
          type: :success
        :no_updates
      {:error, reason} ->
        Logger.error ">> encountered an error checking for updates! #{reason}"
        {:error, reason}
    end
  end

  @doc """
    Checks for updates
  """
  @spec check_updates :: {:update, binary} | :no_updates | {:error, term}
  def check_updates do
    current = Farmbot.BotState.get_os_version
    if String.contains?(current, "rc") do
      msg = "Release Candidate Releases don't currently support updates!"
      Logger.info msg, type: :warn
      :no_updates
    else
      do_http_req()
    end
  end

  @spec check_updates :: {:update, binary} | :no_updates | {:error, term}
  defp do_http_req do
    case HTTPoison.get(releases_url(), @headers, @ssl_hack) do
       {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
         json = Poison.decode!(body)
         version = json["tag_name"]
         version_without_v = String.trim_leading version, "v"
         list = json["assets"]
         item = Enum.find(list, fn(item) ->
           item["name"] == "farmbot-#{@target}-#{version_without_v}.fw"
         end)
         url = item["browser_download_url"]
         {:update, url}
       {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  @doc """
    Installs an update from a url
  """
  @spec install_updates(String.t) :: no_return
  def install_updates(url) do
    # Ignore the compiler warning here.
    # "I'll fix it later i promise" -- Connor Rigby
    case Process.whereis(Downloader) do
      pid when is_pid(pid) -> :ok
      _ -> Downloader.start_link()
    end
    path = Downloader.run(url, @path)
    case File.stat(path) do
      {:ok, file} ->
        Logger.info "Found file: #{inspect file}", type: :success
      e -> Logger.error "Could not find update file: #{inspect e}"
    end
    FS.transaction fn ->
      Logger.info "Seting up post update!", type: :busy
      path = "#{FS.path()}/.post_update"
      :ok = File.write(path, "DONT CAT ME\r\n")
    end
    mod(@target).install(path)
    Farmbot.System.reboot()
  end

  @spec post_install :: no_return
  def post_install, do: mod(@target).post_install()

  @callback install(binary) :: no_return
  @callback post_install() :: no_return
end
