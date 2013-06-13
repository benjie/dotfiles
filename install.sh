#!/bin/bash
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s "`pwd`"/vimrc ../.vimrc
ln -s "`pwd`"/zshrc ../.zshrc
ln -s "`pwd`"/profile_common ../.profile_common
mkdir -p ~/.vim/plugin/after/
ln -s vim/plugin/after/* ~/.vim/plugin/after/
vim -c 'BundleInstall!' -c "q" -c "q"
cd ~/.vim/bundle/YouCompleteMe && ./install.sh; cd -
