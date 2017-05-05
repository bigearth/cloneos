defmodule CloneOS.System.NervesCommon do
  @moduledoc """
    Common functionality for nerves devices.
  """
  defmacro __using__(target: _) do
    quote do
      def reboot, do: Nerves.Firmware.reboot()

      def power_off, do: Nerves.Firmware.poweroff()

      def factory_reset do
        CloneOS.System.FS.transaction fn() ->
          File.rm_rf "#{path()}/config.json"
          File.rm_rf "#{path()}/secret"
          File.rm_rf "#{path()}/farmware"
          reboot()
        end
      end

      defp path, do: CloneOS.System.FS.path()
    end
  end
end
