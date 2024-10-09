#!/bin/bash
cat <<'HERE'

Don't forget to:

- sudo add-apt-repository ppa:neovim-ppa/unstable
- sudo add-apt-repository ppa:aos1/diff-so-fancy
- sudo apt update
- Extract Fira Code Nerd Font to `~/.fonts`
- fc-cache -fv
- sudo apt install powerline neovim python3-neovim python3-pip curl tmux build-essential tig silversearcher-ag neovim diff-so-fancy ripgrep pipx colordiff
- curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
- nvm install 20
- pipx install powerline-status

Press enter to continue

HERE
read
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.vim/bundle
mkdir -p ~/.config/nvim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s "`pwd`"/vimrc ../.vimrc
ln -s "`pwd`"/init.lua ../.config/nvim/init.lua
ln -s "`pwd`"/coc-settings.json ../.config/nvim/coc-settings.json
ln -s "`pwd`"/vscode.init.vim ../.config/nvim/vscode.init.vim
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
ln -s "`pwd`"/psqlrc ../.psqlrc
ln -s "`pwd`"/inputrc ../.inputrc
mkdir -p ~/.vim/plugin/after/
ln -s "`pwd`"/vim/plugin/after/* ~/.vim/plugin/after/
ln -s "`pwd`"/vim/UltiSnips ../.vim/UltiSnips
#nvim +PlugInstall +"CocInstall coc-tsserver" +qall

echo '. ~/.profile_common' >> ~/.bashrc
touch ~/.profile_common.local
chmod +x ~/.profile_common.local
