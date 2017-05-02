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
    Logger.info ">> Booting CloneOS version: #{@version} - #{@commit}"
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, CloneOS.Configurator.Router, [], port: 8080)
    ]

    Logger.info "Started application"

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
