defmodule Module.concat([Farmbot, System, "rpi2", Updates]) do
  use CloneOS.System.NervesCommon.Updates, target: "rpi2"
end
