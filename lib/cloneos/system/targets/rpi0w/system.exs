defmodule Module.concat([Farmbot, System, "rpi0w"]) do
  @moduledoc false
  @behaviour CloneOS.System

  use CloneOS.System.NervesCommon, target: "rpi0w"
end
