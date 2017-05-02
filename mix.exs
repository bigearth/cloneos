defmodule CloneOS.Mixfile do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"
  @version Path.join(__DIR__, "VERSION") |> File.read! |> String.strip

  defp commit() do
    {t,_} = System.cmd("git", ["log", "--pretty=format:%h", "-1"])
    t
  end

  Mix.shell.info([:green, """
  Env
    MIX_TARGET:      #{@target}
    MIX_ENV:         #{Mix.env}
  """, :reset])
  def project do
    [app: :cloneos,
     description: "The Brains of Clone",
     version: "0.1.2",
     elixir: "~> 1.4.0",
     target: @target,
     commit: commit(),
     archives: [nerves_bootstrap: "~> 0.3.0"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(@target),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application, do: application(@target)

  # Specify target specific application configurations
  # It is common that the application start function will start and supervise
  # applications which could cause the host to fail. Because of this, we only
  # invoke CloneOS.start/2 when running on a target.
  def application("host") do
    [mod: {CloneOS, []},
     extra_applications: [:logger]]
  end
  def application(_target) do
    [mod: {CloneOS, []},
     extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  def deps do
    [{:nerves, "~> 0.5.0", runtime: false}] ++
    deps(@target)
  end

  # Specify target specific dependencies
  def deps("host") do
    [
      {:cowboy, "~> 1.1.2"},
      {:plug, "~> 1.3.4"}
    ]
  end
  def deps(target) do
    [
      {:nerves_runtime, "~> 0.1.0"},
      {:"nerves_system_#{target}", "~> 0.11.0", runtime: false},
      {:cowboy, "~> 1.1.1"},
      {:plug, "~> 1.3.4"}
    ]
  end

  # We do not invoke the Nerves Env when running on the Host
  def aliases("host"), do: []
  def aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
