#!/bin/sh

# wget 'https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh'
# bash Anaconda3-5.3.1-Linux-x86_64.sh

cur_dir="$(pwd)"
echo "Install essential"
# sudo apt install build-essential cmake vim python3-dev

echo "Create softlink files..."
#cp bashrc ~/.bashrc
cp bash_aliases ~/.bash_aliases
ln -s $cur_dir/fake_home/vimrc ~/.vimrc
ln -s $cur_dir/fake_home/ycm_extra_conf.py ~/.ycm_extra_conf
ln -s $cur_dir/fake_home/tmux.conf ~/.tmux.conf
ln -s $cur_dir/fake_home/condarc ~/.condarc

echo "Setup Vim, YouCompleteMe"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer

echo "Setup Black"
cd ~/.vim/bundle/black
git checkout origin/stable -b stable

echo "Set up Git"
git config --global core.autocrlf input
git config --global --add alias.root '!pwd'


echo "Create config folder"
ln -sn $cur_dir/fake_home/config/i3/ ~/.config/i3/
ln -sn $cur_dir/fake_home/config/alacritty/ ~/.config/alacritty/

cd $cur_dir
