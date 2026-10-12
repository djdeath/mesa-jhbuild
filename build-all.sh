#!/bin/sh

./mesa-jhbuild build --nodeps Vulkan-ValidationLayers
./mesa-jhbuild build --nodeps SPIRV-Tools
#./mesa-jhbuild build --nodeps llvm-spirv
./mesa-jhbuild build --nodeps mesa

cp vktrace_run vkdebug_run $HOME/mesa/build/bin/
