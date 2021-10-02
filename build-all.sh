#!/bin/sh

./mesa-jhbuild build --nodeps mesa
./mesa-jhbuild build --nodeps Vulkan-ValidationLayers
./mesa-jhbuild build --nodeps llvm-spirv
