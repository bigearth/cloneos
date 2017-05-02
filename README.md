# CloneOS

The brains of the Clone.

* Written w/ the [nerves project](http://nerves-project.org/) and [Elixir](http://elixir-lang.org/).
* Inspired by [FarmbotOS](https://github.com/FarmBot/farmbot_os).
* Uses [Marlin Firmware](http://marlinfw.org/)

## Steps

We target [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/).

1. Clone this repo
  * `git clone git@github.com:bigearth/cloneos.git`
2. Build the frontend
  * `npm install`
  * `npm run build`
3. Get dependencies
  * `MIX_TARGET=rpi3 mix deps.get`
4. Compile dependencies
  * `MIX_TARGET=rpi3 mix deps.compile`
5. Create firmware
  * `MIX_TARGET=rpi3 mix firmware`
