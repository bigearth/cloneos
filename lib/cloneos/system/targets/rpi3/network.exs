defmodule Module.concat([Farmbot, System, "rpi3", Network]) do
  use CloneOS.System.NervesCommon.Network, target: "rpi3", modules: ["brcmfmac"]
end
