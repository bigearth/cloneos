defmodule Module.concat([Farmbot, System, "rpi0w", Network]) do
  use CloneOS.System.NervesCommon.Network, target: "rpi0w", modules: ["brcmfmac"]
end
