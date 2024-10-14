source $ZSH_CONFIG_PATH/util.zsh

autoload -Uz compinit && compinit

if [[ ! -z "$(command -v hx)" ]]; then
  export EDITOR="hx"
else
  export EDITOR="vim"
fi
export PATH=$HOME/Library/Android/sdk/platform-tools:$HOME/go/bin:$HOME/.local/bin:/opt/homebrew/bin:$PATH
export LC_ALL="en_US.UTF-8"

if [[ -d "$HOME/.zinit" ]]; then
  export ZINIT_HOME="$HOME/.zinit"
  source "${ZINIT_HOME}/zinit.zsh"

  zinit ice wait lucid

  zinit light zsh-users/zsh-syntax-highlighting
  zinit light zsh-users/zsh-autosuggestions
  zinit light joshskidmore/zsh-fzf-history-search

  zinit ice depth=1
  zinit light jeffreytse/zsh-vi-mode
else
  # Some fallback configs

  # Vi Mode
  bindkey -v
  bindkey ^R history-incremental-search-backward 
  bindkey ^S history-incremental-search-forward
fi

alias e="$EDITOR"

set_alias_if_exists ls lsd "lsd"
set_alias_if_exists ll lsd "lsd -l" "ls -l"
set_alias_if_exists lla lsd "lsd -al" "ls -al"

alias ezsh="e $HOME/.zshrc"
alias sozsh=". $HOME/.zshrc"

set_alias_if_exists k kubectl-check "kubectl check" "kubectl"
set_alias_if_exists ktx kubectx kubectxl
set_alias_if_exists ktx kubens kubens
set_alias_if_exists ku k9s "k9s"
set_alias_if_exists kh k9s "k9s --headless"

set_alias_if_exists cdiff chezmoi "chezmoi diff"
set_alias_if_exists cadd chezmoi "chezmoi add"
set_alias_if_exists cupdate chezmoi "chezmoi update"
set_alias_if_exists cedit chezmoi "chezmoi edit"
set_alias_if_exists capply chezmoi "chezmoi apply"

set_alias_if_exists zj zellij "zellij"

if [[ command_exists starship ]]; then
  eval "$(starship init zsh)"
fi

if [[ -d "$HOME/.asdf" ]]; then
  . "$HOME/.asdf/asdf.sh"
fi

if [[ ! -z "$(command -v zoxide)" ]]; then
  eval "$(zoxide init zsh)"
else
  . $HOME/.scripts/z.sh
fi

if [[ ! -z "$(command -v carapace)" ]]; then
  export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace)
fi

if [[ ! -z "$(command -v direnv)" ]]; then
  eval "$(direnv hook zsh)"
fi

source $ZSH_CONFIG_PATH/git.zsh
