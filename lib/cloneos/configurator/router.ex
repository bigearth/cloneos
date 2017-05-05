defmodule CloneOS.Configurator.Router do
  @moduledoc """
    Routes incoming connections.
  """
  alias CloneOS.System.FS.ConfigStorage
  use Plug.Router
  require Logger

  if Mix.env == :dev, do: use Plug.Debugger, otp_app: :cloneos
  plug Plug.Logger
  plug Plug.Static, at: "/", from: :cloneos
  plug :match
  plug :dispatch

  get "/", do: conn |> send_resp(200, make_html())

  # Flash marlin fw. <3 <3 <3
  get "/api/flash_firmware" do
    "#{:code.priv_dir(:cloneos)}/firmware.hex" |> handle_arduino(conn)
  end

  defp make_html do
    "#{:code.priv_dir(:cloneos)}/static/index.html" |> File.read!
  end

  defp handle_arduino(file, conn) do
    errrm = fn(blerp) ->
      receive do
        :done ->
          blerp |> send_resp(200, "OK")
        {:error, reason} ->
          blerp |> send_resp(400, inspect(reason))
      end
    end

    Logger.info ">> is installing a firmware update. "
      <> " I may act weird for a moment", channels: [:toast]

    # pid = Process.whereis(CloneOS.Serial.Handler)
    #
    # if pid do
    #   GenServer.cast(CloneOS.Serial.Handler, {:update_fw, file, self()})
    #   errrm.(conn)
    # else
    #   Logger.info "doing some magic..."
    #   herp = Nerves.UART.enumerate()
    #   |> Map.drop(["ttyS0","ttyAMA0"])
    #   |> Map.keys
    #   case herp do
    #     [tty] ->
    #       Logger.info "magic complete!"
    #       CloneOS.Serial.Handler.flash_firmware(tty, file, self())
    #       errrm.(conn)
    #     _ ->
    #       Logger.warn "Please only have one serial device when updating firmware"
    #       conn |> send_resp(200, "OK")
    #   end
    # end
  end

  match _, do: send_resp(conn, 404, "Oops!")
end
