defmodule CloneOS.Configurator do
  @moduledoc """
    A plug web application with a mini REST interface.
  """
  use Supervisor
  require Logger
  @port 4000

  def init([]) do
    Logger.info ">> Configurator init!"
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, CloneOS.Configurator.Router, [], port: @port),
    ]
    opts = [strategy: :one_for_one]
    supervise(children, opts)
  end

  def start_link, do: Supervisor.start_link(__MODULE__, [], name: __MODULE__)
end
