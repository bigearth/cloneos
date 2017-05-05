defmodule Module.concat([Farmbot, System, "rpi", Updates]) do
  use CloneOS.System.NervesCommon.Updates, target: "rpi"
end
