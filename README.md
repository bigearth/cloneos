# CloneOS

The brains of the Clone.

* Written w/ the [nerves project](http://nerves-project.org/) and [Elixir](http://elixir-lang.org/).
* Inspired by [FarmbotOS](https://github.com/FarmBot/farmbot_os).

## Steps

We target [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/).

1. Clone this repo
  * `git clone git@github.com:bigearth/cloneos.git`
2. Get dependencies
  * `MIX_TARGET=rpi3 mix deps.get`
3. Compile dependencies
  * `MIX_TARGET=rpi3 mix deps.compile`
4. Create firmware
  * `MIX_TARGET=rpi3 mix firmware`
