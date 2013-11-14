#!/bin/bash
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s "`pwd`"/vimrc ../.vimrc
ln -s "`pwd`"/zshrc ../.zshrc
ln -s "`pwd`"/profile_common ../.profile_common
ln -s "`pwd`"/tmux.conf ../.tmux.conf
ln -s "`pwd`"/gitconfig ../.gitconfig
ln -s "`pwd`"/ackrc ../.ackrc
ln -s "`pwd`"/ctags ../.ctags
mkdir -p ~/.vim/plugin/after/
ln -s vim/plugin/after/* ~/.vim/plugin/after/
vim +BundleInstall +qall
cd ~/.vim/bundle/YouCompleteMe && ./install.sh; cd -
