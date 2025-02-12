#!/bin/sh

git config --global user.name "Lionel Landwerlin"
git config --global user.email lionel.g.landwerlin@intel.com
git config --global core.editor emacs

sudo usermod -a -G render,video $USER

mkdir -p ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIONWZnl+XiZoKzpQYyoVLNaCW63KIsK1gNzcKBPTFVxl lionel.g.landwerlin@intel.com" > ~/.ssh/authorized_keys

# apt-cache show clang-13 > /dev/null
# retcode=$?
# echo "===========> $retcode"
# if [ $retcode != 0 ]; then
#     wget https://apt.llvm.org/llvm.sh
#     chmod +x llvm.sh
#     sudo -E ./llvm.sh 13
# fi

# sudo apt-get install libllvm13 llvm-13 llvm-13-dev llvm-13-doc llvm-13-examples llvm-13-runtime
# sudo apt-get install clang-13 clang-tools-13 clang-13-doc libclang-common-13-dev libclang-13-dev libclang1-13 clang-format-13 clangd-13
# sudo apt-get install libclc-13-dev

sudo apt-get install emacs python3-pip screen libxml2-dev libxcb-glx0-dev libxcb-damage0-dev \
     libxcb-present-dev libxshmfence-dev libx11-xcb-dev libxcb-dri2-0-dev libxcb-dri3-dev libepoxy-dev \
     libgtk-3-dev python3-ply libembree-dev libpciaccess-dev libtool cmake flex libxxf86vm-dev bison \
     valgrind libwaffle-dev python3-numpy python3-mako meson socat python3-pil.imagetk python3-pil
#sudo apt-get remove meson

#pip3 install meson

# Emacs stuff
mkdir -p ~/src
cd ~/src
git clone https://github.com/djdeath/custom-modes
cd -

sudo apt-get install emacsen-common emacs-el
ln -s ~/src/custom-modes/.emacs.el ~/.emacs.el
