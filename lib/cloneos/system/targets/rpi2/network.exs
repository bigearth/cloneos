defmodule Module.concat([Farmbot, System, "rpi2", Network]) do
  use CloneOS.System.NervesCommon.Network, target: "rpi2", modules: []
end
