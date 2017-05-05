defmodule Module.concat([Farmbot, System, "rpi", Network]) do
  use CloneOS.System.NervesCommon.Network, target: "rpi", modules: []
end
