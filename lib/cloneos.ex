defmodule CloneOS do
  @moduledoc """
    Supervises the individual modules that make up CloneOS.
  """
  require Logger
  use Supervisor

  @version Mix.Project.config[:version]
  @commit Mix.Project.config[:commit]

  @doc """
    Entry Point to CloneOS
  """
  def start(type, args)
  def start(_, _args) do
    Logger.info ">> Booting CloneOS by EARTH version: #{@version} - #{@commit}"

    Supervisor.start_link(__MODULE__, [], name: CloneOS.Supervisor)
  end

  def init(_args) do
    children = [
      supervisor(CloneOS.Configurator, [], restart: :permanent)
    ]
    opts = [strategy: :one_for_one]
    supervise(children, opts)
  end
end
