#!/bin/bash
SYSTEM=$1
export MIX_ENV=prod
export MIX_TARGET=$SYSTEM
echo "building firmware for $SYSTEM"
npm install yarn
yarn install
yarn build
mix deps.get
mix firmware
