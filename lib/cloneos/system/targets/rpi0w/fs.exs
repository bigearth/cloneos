defmodule Module.concat([Farmbot, System, "rpi0w", FileSystem]) do
  @moduledoc false
  @behaviour CloneOS.System.FS
  @state_path Application.get_env(:cloneos, :path)
  @block_device "/dev/mmcblk0p3"
  @fs_type "ext4"
  @ro_options ["-t", @fs_type, "-o", "ro,remount", @block_device, @state_path]
  @rw_options ["-t", @fs_type, "-o", "rw,remount", @block_device, @state_path]
  use CloneOS.System.NervesCommon.FileSystem,
      target: "rpi0w",
      ro_options:   @ro_options,
      rw_options:   @rw_options,
      state_path:   @state_path,
      fs_type:      @fs_type,
      block_device: @block_device
end
