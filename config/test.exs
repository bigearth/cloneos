use Mix.Config
import_config "dev.exs"

# We hopefully don't need logger  ¯\_(ツ)_/¯
config :logger, :console,
  format: ""

config :cloneos,
  path: "/tmp",
  config_file_name: "default_config.json",
  tty: "/dev/tnt1"

config :cloneos, auth_callbacks: []

# frontend <-> bot transports.
config :cloneos, transports: []

config :cloneos, logger: false
