#!/bin/sh
cd

### zsh
ln -sf ~/dotfiles/.zshrc  ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/.zsh    ~/.zsh
mkdir ~/.zsh_history/
mkdir ~/.zsh/modules/
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
mv zsh-syntax-highlighting ~/.zsh/modules/

### git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tigrc     ~/.tigrc

### mercurial
ln -sf ~/dotfiles/.hgrc ~/.hgrc

### emacs
ln -sf ~/dotfiles/.emacs.d ~/.emacs.d

### screen
ln -sf ~/dotfiles/.screenrc ~/.screenrc

### tmux
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

############
# perlbrew #
############
curl -L http://xrl.us/perlbrewinstall | bash
~/perl5/perlbrew/bin/perlbrew init
source ~/perl5/perlbrew/etc/bashrc
perlbrew install -j 5 perl-5.14.1
perlbrew switch perl-5.14.1
perlbrew install-cpanm

##############
# pythonbrew #
##############
curl -kLO https://github.com/utahta/pythonbrew/raw/master/pythonbrew-install
chmod +x pythonbrew-install
./pythonbrew-install
source ~/.pythonbrew/etc/bashrc
pythonbrew install 2.7.2
pythonbrew switch 2.7.2
rm pythonbrew-install

