defmodule CloneOS.System.Supervisor do
  @moduledoc """
    Supervises Platform specific stuff for Farmbot to operate
  """
  use Supervisor
  @redis_config Application.get_all_env(:cloneos)[:redis]
  @target Mix.Project.config()[:target]

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(CloneOS.System.FS, [@target], restart: :permanent),
      worker(CloneOS.System.FS.Worker, [@target], restart: :permanent),
      worker(CloneOS.System.FS.ConfigStorage, [], restart: :permanent),
      worker(CloneOS.System.Network, [@target], restart: :permanent),
      worker(CloneOS.System.UeventHandler, [], restart: :permanent)
    ] ++ maybe_redis()
    opts = [strategy: :one_for_one]
    supervise(children, opts)
  end

  @spec maybe_redis :: [Supervisor.Spec.spec]
  defp maybe_redis do
     if @redis_config[:server] do
       [worker(Redis.Server, [], restart: :permanent)]
     else
       []
     end
  end
end
