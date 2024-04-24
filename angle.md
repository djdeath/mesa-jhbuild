# How to compile Angle

    gn gen out/Debug
    ninja -C out/Debug

# How to run Angle dEQP tests

    cd out/Debug
    export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH
    ./angle_deqp_gles31_tests
