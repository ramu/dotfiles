#!/bin/bash
cd
mkdir ~/log/
mkdir ~/bin/
mkdir ~/tmp/
mkdir ~/work/

### zsh
ln -sf ~/dotfiles/.zshrc  ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/.zsh    ~/.zsh
mkdir ~/log/.zsh_history/
mkdir ~/.zsh/modules/
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/modules/
git clone git@github.com:jonmosco/kube-ps1.git ~/.zsh/modules/kube-ps1/ 
git clone git://github.com/hchbaw/auto-fu.zsh.git ~/.zsh/modules/auto-fu/
git clone https://github.com/mollifier/cd-gitroot.git ~/.zsh/modules/cd-gitroot

### git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tigrc     ~/.tigrc

### emacs
ln -sf ~/dotfiles/.emacs.d ~/.emacs.d
mkdir ~/dotfiles/.emacs.d/history
mkdir ~/dotfiles/.emacs.d/var/.docsets

### screen
ln -sf ~/dotfiles/.screenrc ~/.screenrc

### tmux
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

### vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/tmp

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

# TODO: 要見直し
### perlbrew
#curl -L https://install.perlbrew.pl | bash
#~/perl5/perlbrew/bin/perlbrew init
#source ~/perl5/perlbrew/etc/bashrc
#perlbrew install -j 5 perl-5.14.1
#perlbrew switch perl-5.14.1
#perlbrew install-cpanm

# TODO: 要見直し
### pythonbrew
#curl -kLO https://github.com/utahta/pythonbrew/raw/master/pythonbrew-install
#chmod +x pythonbrew-install
#./pythonbrew-install
#source ~/.pythonbrew/etc/bashrc
#pythonbrew install 2.7.2
#pythonbrew switch 2.7.2
#rm pythonbrew-install

### homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install bat
cargo install fd-find
cargo install git-delta
cargo install grex
cargo install lsd
cargo install ripgrep
cargo install tokei

### tmux-thumbs
git clone https://github.com/fcsonline/tmux-thumbs ~/.tmux/plugins/tmux-thumbs
cd ~/.tmux/plugins/tmux-thumbs
cargo build --release

### pry
ln -sf ~/dotfiles/.pryrc ~/.pryrc

### ripgrep
ln -sf ~/dotfiles/.ripgrep ~/.ripgrep
