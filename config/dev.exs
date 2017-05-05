use Mix.Config

config :cloneos,
  configurator_port: System.get_env("CONFIGURATOR_PORT") || 5000,
  tty: System.get_env("ARDUINO_TTY")
