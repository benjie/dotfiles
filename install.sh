#!/bin/bash
cat <<'HERE'

Don't forget to globally/main account:

- echo fs.inotify.max_user_watches=1048576 | sudo tee -a /etc/sysctl.d/99-benjie.conf
- echo fs.inotify.max_user_instances=1024 | sudo tee -a /etc/sysctl.d/99-benjie.conf
- sudo add-apt-repository ppa:neovim-ppa/unstable
- sudo add-apt-repository ppa:aos1/diff-so-fancy
- sudo apt update
- sudo apt install powerline neovim python3-neovim python3-pip curl tmux build-essential tig silversearcher-ag neovim diff-so-fancy ripgrep pipx pspg colordiff xclip pspg postgresql-client-16 git-delta rustup
- Extract Fira Code Nerd Font to `~/.fonts`
- fc-cache -fv
- pipx install powerline-status

Per account:

- curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
- nvm install 24
- rustup default stable
- cargo install --locked tree-sitter-cli

Press enter to continue

HERE
read
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#mkdir -p ~/.vim/bundle
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#ln -s "`pwd`"/vimrc ../.vimrc
#ln -s "`pwd`"/init.lua ../.config/nvim/init.lua
#ln -s "`pwd`"/coc-settings.json ../.config/nvim/coc-settings.json
#ln -s "`pwd`"/vscode.init.vim ../.config/nvim/vscode.init.vim
mkdir -p ~/.config
ln -s "`pwd`"/nvim ../.config/nvim

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
#mkdir -p ~/.vim/plugin/after/
## ln -s "`pwd`"/vim/plugin/after/* ~/.vim/plugin/after/
#for I in "`pwd`"/vim/plugin/after/*; do
#  ln -s "$I" ~/.vim/plugin/after/
#done
#ln -s "`pwd`"/vim/UltiSnips ../.vim/UltiSnips
#nvim +PlugInstall +"CocInstall coc-tsserver" +qall

echo '. ~/.profile_common' >> ~/.bashrc
touch ~/.profile_common.local
chmod +x ~/.profile_common.local
