#!/bin/bash
SYSTEM=$1
NERVES_SYSTEM_BR_GIT="https://github.com/nerves-project/nerves_system_br"

if [ -d "nerves/NERVES_SYSTEM_$SYSTEM" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo "NERVES_SYSTEM_$SYSTEM dir found."
else
  echo "NERVES_SYSTEM_$SYSTEM dir not found."
  git clone $NERVES_SYSTEM_BR_GIT nerves/nerves_system_br
fi

# nerves/nerves_system_br/create-build.sh nerves/nerves_system_$SYSTEM/nerves_defconfig nerves/NERVES_SYSTEM_$SYSTEM
# if [ ! -f nerves/nerves_system_br/buildroot/.farmbot_applied_patches_list ]; then
#   echo "Applying FarmbotOS patches"
#   nerves/nerves_system_br/buildroot/support/scripts/apply-patches.sh nerves/nerves_system_br/buildroot patches
#   cp nerves/nerves_system_br/buildroot/.applied_patches_list nerves/nerves_system_br/buildroot/.farmbot_applied_patches_list
#   nerves/nerves_system_br/create-build.sh nerves/nerves_system_$SYSTEM/nerves_defconfig nerves/NERVES_SYSTEM_$SYSTEM
# fi
