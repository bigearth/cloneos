defmodule CloneOS.Configurator do
  @moduledoc """
    A plug web application with a mini REST interface.
  """
  use Supervisor
  alias CloneOS.Configurator.Router
  require Logger

  def init([]) do
    Logger.info ">> Configurator init!"
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Router, [], port: 8080),
    ]
    opts = [strategy: :one_for_one]
    supervise(children, opts)
  end

  def start_link, do: Supervisor.start_link(__MODULE__, [], name: __MODULE__)
end
