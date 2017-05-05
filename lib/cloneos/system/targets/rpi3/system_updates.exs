defmodule Module.concat([Farmbot, System, "rpi3", Updates]) do
  use CloneOS.System.NervesCommon.Updates, target: "rpi3"
end
