export VK_ICD_FILENAMES=$HOME/mesa/build/share/vulkan/icd.d/intel_icd.x86_64.json
export VK_ENABLE_PIPELINE_CACHE=0
export MESA_VK_ABORT_ON_DEVICE_LOSS=1
./mesa-jhbuild shell
