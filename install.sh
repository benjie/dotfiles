#!/bin/bash
ln -s "`pwd`"/vimrc ../.vimrc
mkdir -p ~/.vim/plugin/after/
ln -s vim/plugin/after/* ~/.vim/plugin/after/
