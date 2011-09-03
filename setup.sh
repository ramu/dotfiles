#!/bin/sh
cd

########
# link #
########
# zsh
ln -sf ~/dotfiles/.zshrc  ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/.zsh    ~/.zsh
mkdir ~/.zsh_history/

# git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tigrc     ~/.tigrc

# mercurial
ln -sf ~/dotfiles/.hgrc ~/.hgrc

# emacs
ln -sf ~/dotfiles/.emacs.d ~/.emacs.d

# screen
ln -sf ~/dotfiles/.screenrc ~/.screenrc

############
# perlbrew #
############
curl -L http://xrl.us/perlbrewinstall | bash
~/perl5/perlbrew/bin/perlbrew init
source ~/perl5/perlbrew/etc/bashrc
perlbrew install -j 5 perl-5.14.1
perlbrew switch perl-5.14.1
perlbrew install-cpanm

