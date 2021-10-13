#!/bin/sh

git config --global user.name "Lionel Landwerlin"
git config --global user.email lionel.g.landwerlin@intel.com
git config --global core.editor emacs

sudo usermod -a -G render,video $USER

mkdir -p ~/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+9tH8pq2uzePGign9lyV3SbViGHlWqzzXDbjpqvwL2wpZB1l+8oLsQ82gl4D077rUbp7nc9EdruvdzYx7lCkhUEtzhKmdK98EskzBEQ8TlsFYLGjGPqcDcvVBRSitwyV3VfQie1o8uhzqhyc2JWX37SwKh9GRHmMOF0GYNj22SVxOE4/jlo+t6rOSO2Z+/XMPt7rJvPkMX8wZ8SkD/L4aCeANFOSU7Z+Myzn1abWPn1FflD1wO7gazGTgw+Mmp+YBKxFuLyjWe+Sb4TuJIyP/Y2rlmHOLBqXdcfqU3zzVqxk04sN+WpOKnHFTMBXvfViRklVZgGY3CKIA3FPfqNbMSIpU0aRx7+xPJCC2XUaGpZf4SG3diPmtSWWVsKbfEkpHA6ABUT8aIhp44LAzpyqwik6UfNNloNf1IzG3ZvkSqSbbOJeLSym4B4Tkz2cUtKfwYIdQTsN8q4J24LMJ10ZamFF/3MZEUP6OsOpobDyhEHkbGsxd4ezQCqbddRVLgJaruDbTamn3zf+OgAoOz+Xs2q5HMuf47YnKmxIrMutNcDAboqPI0MSRB1AxTdXxDjLIWtgnVhOJnntz/dOAOX0GpgZa4cGKejCx61X0agdDt+4Wiw2887gqQY4jQaSFtq1MnomJ75vAK+UF7zOElJ3VywuFa2rlvr6tuSpd5NmDAQ== lionel.g.landwerlin@intel.com" > ~/.ssh/authorized_keys

apt-cache show clang-13 > /dev/null
retcode=$?
echo "===========> $retcode"
if [ $retcode != 0 ]; then
    wget https://apt.llvm.org/llvm.sh
    chmod +x llvm.sh
    sudo -E ./llvm.sh 13
fi

sudo apt-get install libllvm13 llvm-13 llvm-13-dev llvm-13-doc llvm-13-examples llvm-13-runtime
sudo apt-get install clang-13 clang-tools-13 clang-13-doc libclang-common-13-dev libclang-13-dev libclang1-13 clang-format-13 clangd-13
sudo apt-get install libclc-13-dev

sudo apt-get install emacs jhbuild python3-pip screen libxml2-dev libxcb-glx0-dev libxcb-damage0-dev libxcb-present-dev libxshmfence-dev libx11-xcb-dev libxcb-dri2-0-dev libxcb-dri3-dev libepoxy-dev libgtk-3-dev python3-ply
sudo apt-get remove meson

pip3 install meson

# Emacs stuff
cd ~/src
git clone https://github.com/djdeath/custom-modes
cd -

sudo apt-get install emacsen-common emacs-el emacs-common-non-dfsg
ln -s ~/src/custom-modes/.emacs.el ~/.emacs.el
