defmodule Module.concat([Farmbot, System, "rpi2"]) do
  @moduledoc false
  @behaviour CloneOS.System

  use CloneOS.System.NervesCommon, target: "rpi2"
end
