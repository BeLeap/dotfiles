export K9S_CONFIG_DIR=$HOME/.config/k9s

set_alias_if_exists k kubectl-check "kubectl check" "kubectl"
set_alias_if_exists ktx kubectx kubectx
set_alias_if_exists kns kubens kubens
set_alias_if_exists ku k9s "k9s"
set_alias_if_exists kh k9s "k9s --headless"

