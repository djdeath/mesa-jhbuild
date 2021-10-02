#!/bin/sh

git config --global user.name "Lionel Landwerlin"
git config --global user.email lionel.g.landwerlin@intel.com
git config --global core.editor emacs

apt-cache show clang-13 > /dev/null
retcode=$?
echo "===========> $retcode"
if [ $retcode != 0 ]; then
    wget https://apt.llvm.org/llvm.sh
    chmod +x llvm.sh
    sudo -E ./llvm.sh 13
fi

sudo apt-get install libllvm-13-ocaml-dev libllvm13 llvm-13 llvm-13-dev llvm-13-doc llvm-13-examples llvm-13-runtime
sudo apt-get install clang-13 clang-tools-13 clang-13-doc libclang-common-13-dev libclang-13-dev libclang1-13 clang-format-13 python-clang-13 clangd-13
sudo apt-get install libclc-13-dev

sudo apt-get install emacs jhbuild python3-pip screen libxml2-dev libxcb-glx0-dev libxcb-damage0-dev libxcb-present-dev libxshmfence-dev libx11-xcb-dev libxcb-dri2-0-dev libxcb-dri3-dev libepoxy-dev libgtk-3-dev
sudo apt-get remove meson

pip3 install meson
