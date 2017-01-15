#!/bin/bash
mkdir -p ~/.vim/bundle
mkdir -p ~/.config/nvim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s "`pwd`"/vimrc ../.vimrc
ln -s "`pwd`"/vimrc ../.config/nvim/init.vim
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
/usr/local/bin/nvim +PlugInstall +qall
