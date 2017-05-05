defmodule Module.concat([Farmbot, System, "host", FileSystem]) do
  @moduledoc false
  @behaviour CloneOS.System.FS
  def fs_init, do: :ok
  def mount_read_only, do: :ok
  def mount_read_write, do: :ok
end
