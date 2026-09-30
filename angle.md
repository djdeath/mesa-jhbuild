# How to compile Angle

    mkdir angle; cd angle; fetch angle # Wait for 10 fucking hours to download 20 fucking GiB
    gn gen out/Debug
    ninja -C out/Debug

# How to run Angle dEQP tests

    cd out/Debug
    export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH
    ./angle_deqp_gles31_tests
