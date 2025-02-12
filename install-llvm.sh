#!/bin/sh

ver=$1

sudo apt-get install llvm-spirv-$ver llvm-$ver-dev libllvmspirvlib-$ver-dev libclang-$ver-dev libclang-common-$ver-dev
