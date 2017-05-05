defmodule CloneOS.Mixfile do
  use Mix.Project

  require Logger
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
     version: @version,
     elixir: "~> 1.4.0",
     package: package(),
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

  def package do
    [name: "CloneOS",
    maintainers: "EARTH",
    licenses: "GPLv2"]
  end

  # Configuration for the OTP application.
  #

  # Specify target specific application configurations
  # It is common that the application start function will start and supervise
  # applications which could cause the host to fail. Because of this, we only
  # invoke CloneOS.start/2 when running on a target.
  def application do
    [mod: {CloneOS, []},
     extra_applications: applications() ++ applications(@target)]
  end

  # common for test, prod, and dev
  defp applications do
    [
      :logger
    ]
  end

  defp applications("host"), do: []
  defp applications(_system) do
    [
      :nerves_interim_wifi
    ]
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
    [
      {:nerves, "~> 0.5.1", runtime: false},
      {:poison, "~> 3.0"},
      {:httpoison, github: "edgurgel/httpoison", override: true},
      {:cowboy, "~> 1.1.2"},
      {:plug, "~> 1.3.4"}
    ] ++
    deps(@target)
  end

  # Specify target specific dependencies
  def deps("host"), do: []
  def deps(target) do
    [
      {:nerves_runtime, "~> 0.1.0"},
      {:"nerves_system_#{target}", "~> 0.11.0", runtime: false},
      {:nerves_interim_wifi, github: "nerves-project/nerves_interim_wifi"}
    ]
  end

  # We do not invoke the Nerves Env when running on the Host
  def aliases("host"), do: []
  def aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
