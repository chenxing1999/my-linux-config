#!/bin/sh

# wget 'https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh'
# bash Anaconda3-5.3.1-Linux-x86_64.sh

cur_dir="$(pwd)"
echo "Install essential"
sudo pacman -Syu

# Tools to compile code
sudo pacman -S base-devel cmake yay

# Tools use in daily
sudo pacman -S ripgrep python3-venv i3-gaps alacritty i3status
sudo pacman -S brave

python3 -m venv $HOME/.default_pyenv --prompt py310

echo "Create softlink files..."
#cp bashrc ~/.bashrc
cp bash_aliases ~/.bash_aliases
ln -s $cur_dir/fake_home/vimrc ~/.vimrc
ln -s $cur_dir/fake_home/tmux.conf ~/.tmux.conf
ln -s $cur_dir/fake_home/condarc ~/.condarc
ln -s $cur_dir/fake_home/condarc ~/.bashrc

echo "Setup Vim, YouCompleteMe"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer

echo "Set up Git"
git config --global core.autocrlf input
git config --global --add alias.root '!pwd'


echo "Create config folder"
ln -sn $cur_dir/fake_home/config/i3/ ~/.config/i3/
ln -sn $cur_dir/fake_home/config/alacritty/ ~/.config/alacritty/

# Custom FZF compile better than re-built
echo "Install fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

cd $cur_dir
