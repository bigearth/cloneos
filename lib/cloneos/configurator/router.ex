defmodule CloneOS.Configurator.Router do
  use Plug.Router
  require Logger

  if Mix.env == :dev, do: use Plug.Debugger, otp_app: :cloneos
  plug Plug.Logger
  plug Plug.Static, at: "/", from: :cloneos
  plug :match
  plug :dispatch

  get "/", do: conn |> send_resp(200, make_html())

  defp make_html do
    "#{:code.priv_dir(:cloneos)}/static/index.html" |> File.read!
  end

  match _, do: send_resp(conn, 404, "Oops!")
end
