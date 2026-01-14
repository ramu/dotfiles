#!/bin/bash
cd
mkdir -p ~/log/
mkdir -p ~/bin/
mkdir -p ~/tmp/
mkdir -p ~/work/

### claude code
ln -sf ~/dotfiles/.claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/.claude/commands ~/.claude/commands
ln -sf ~/dotfiles/.claude/scripts ~/.claude/scripts
ln -sf ~/dotfiles/.claude/CLAUDE.md ~/.claude/CLAUDE.md

### zsh
ln -sf ~/dotfiles/.zshrc  ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/.zsh    ~/.zsh
mkdir -p ~/log/.zsh_history/
mkdir -p ~/.zsh/modules/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/modules/zsh-syntax-highlighting
git clone https://github.com/jonmosco/kube-ps1.git ~/.zsh/modules/kube-ps1 
git clone https://github.com/hchbaw/auto-fu.zsh.git ~/.zsh/modules/auto-fu
git clone https://github.com/mollifier/cd-gitroot.git ~/.zsh/modules/cd-gitroot

### git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tigrc     ~/.tigrc

### emacs
ln -sf ~/dotfiles/.emacs.d ~/.emacs.d
mkdir -p ~/dotfiles/.emacs.d/history
mkdir -p ~/dotfiles/.emacs.d/var/.docsets

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
ln -sf ~/dotfiles/.ripgreprc ~/.ripgreprc
