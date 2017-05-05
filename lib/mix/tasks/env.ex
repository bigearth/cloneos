defmodule Mix.Tasks.CloneOS.Env do
  @moduledoc false
  use Mix.Task
  def run(_) do
    Mix.shell.info([:green, "Building initial environment for CloneOS"])
    Code.eval_file("scripts/generate_makefile.exs", File.cwd!)
  end
end
