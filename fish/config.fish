source ~/.dotfiles/fish/alias.fish
source ~/.dotfiles/fish/fzf.fish
source ~/.dotfiles/fish/bash.fish
source ~/.dotfiles/fish/tmux.fish
source ~/.dotfiles/fish/others.fish
source ~/.dotfiles/fish/git.fish
source ~/.dotfiles/fish/docker.fish

set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
set -gx GDK_SCALE 2
