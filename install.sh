#!/bin/bash
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s "`pwd`"/vimrc ../.vimrc
ln -s "`pwd`"/zshrc ../.zshrc
ln -s "`pwd`"/profile_common ../.profile_common
ln -s "`pwd`"/tmux.conf ../.tmux.conf
ln -s "`pwd`"/starttmux.sh ../.starttmux.sh
ln -s "`pwd`"/tmux-general.sh ../.tmux-general.sh
ln -s "`pwd`"/gitconfig ../.gitconfig
ln -s "`pwd`"/ackrc ../.ackrc
ln -s "`pwd`"/ctags ../.ctags
ln -s "`pwd`"/gitignore ../.gitignore
ln -s "`pwd`"/agignore ../.agignore
ln -s "`pwd`"/npmrc ../.npmrc
mkdir -p ~/.vim/plugin/after/
ln -s "`pwd`"/vim/plugin/after/* ~/.vim/plugin/after/
ln -s "`pwd`"/vim/UltiSnips ../.vim/UltiSnips
vim +BundleInstall +qall
cd ~/.vim/bundle/YouCompleteMe && ./install.sh; cd -
