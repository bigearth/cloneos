defmodule CloneOS.Configurator do
  @moduledoc """
    A plug web application with a mini REST interface.
  """
  use Supervisor
  alias CloneOS.Configurator.Router
  require Logger

  @port Application.get_env(:cloneos, :configurator_port, 4000)

  def init([]) do
    Logger.info ">> Configurator init!"
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Router, [], port: @port),
    ]
    opts = [strategy: :one_for_one]
    supervise(children, opts)
  end

  def start_link, do: Supervisor.start_link(__MODULE__, [], name: __MODULE__)
end
