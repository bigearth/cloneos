defmodule Module.concat([Farmbot, System, "rpi"]) do
  @moduledoc false
  @behaviour CloneOS.System

  use CloneOS.System.NervesCommon, target: "rpi"
end
