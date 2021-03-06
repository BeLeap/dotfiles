if status is-interactive
and not set -q TMUX
and not set -q VSCODE_INTEGRATED_TERMINAL
    exec tmux
end

alias sotmux "tmux source ~/.tmux.conf"
alias tinstall "~/.dotfiles/tmux/plugins/tpm/bin/install_plugins"
alias tupdate "~/.dotfiles/tmux/plugins/tpm/bin/update_plugins"
alias tclean "~/.dotfiles/tmux/plugins/tpm/bin/clean_plugins"
