#!/bin/bash
cd
mkdir ~/log/
mkdir ~/bin/
mkdir ~/tmp/

### zsh
ln -sf ~/dotfiles/.zshrc  ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/.zsh    ~/.zsh
mkdir ~/log/.zsh_history/
mkdir ~/.zsh/modules/
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/modules/
git clone git://github.com/hchbaw/auto-fu.zsh.git ~/.zsh/modules/auto-fu/
git clone https://github.com/mollifier/cd-gitroot.git ~/.zsh/modules/cd-gitroot

### git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tigrc     ~/.tigrc
curl https://raw.github.com/git/git/master/contrib/diff-highlight/diff-highlight > ~/bin/diff-highlight
chmod 755 ~/bin/diff-highlight

### mercurial
ln -sf ~/dotfiles/.hgrc ~/.hgrc
mkdir ~/dotfiles/.hg
curl http://mercurial.selenic.com/wiki/InfoExtension?action=AttachFile&do=get&target=info.py > ~/dotfiles/.hg/info.py

### emacs
ln -sf ~/dotfiles/.emacs.d ~/.emacs.d
mkdir ~/dotfiles/.emacs.d/history
mkdir ~/dotfiles/.emacs.d/var/.docsets

### screen
ln -sf ~/dotfiles/.screenrc ~/.screenrc

### tmux
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

### vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/tmp
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

### curl
HOSTNAME=`hostname`
if [ $HOSTNAME = "ubuntu" ];
then
  apt-get install curl
fi
if [ ! -x "`which curl`" ];
then
  echo "curl is not installed."
  exit 255
fi

### perlbrew
curl -L http://xrl.us/perlbrewinstall | bash
~/perl5/perlbrew/bin/perlbrew init
source ~/perl5/perlbrew/etc/bashrc
perlbrew install -j 5 perl-5.14.1
perlbrew switch perl-5.14.1
perlbrew install-cpanm

### pythonbrew
curl -kLO https://github.com/utahta/pythonbrew/raw/master/pythonbrew-install
chmod +x pythonbrew-install
./pythonbrew-install
source ~/.pythonbrew/etc/bashrc
pythonbrew install 2.7.2
pythonbrew switch 2.7.2
rm pythonbrew-install

### homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
