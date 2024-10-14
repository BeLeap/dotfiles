function set_alias_if_exists() {
  local alias_cmd=$1
  local binary=$2
  local preferred_cmd=$3
  local fallback_cmd=${4:-}
  if [[ ! -z "$(command -v $binary)" ]]; then
    alias "$alias_cmd"="$preferred_cmd"
  elif [[ ! -z "$fallback_cmd" ]]; then
    alias "$alias_cmd"="$fallback_cmd"
  fi
}
