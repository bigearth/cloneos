defmodule Module.concat([Farmbot, System, "rpi3"]) do
  @moduledoc false
  @behaviour CloneOS.System

  use CloneOS.System.NervesCommon, target: "rpi3"
end
