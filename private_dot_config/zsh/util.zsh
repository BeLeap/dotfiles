function command_exists() {
  command -v "$1" >/dev/null 2>&1
}

function set_alias_if_exists() {
  local alias_cmd=$1
  local binary=$2
  local preferred_cmd=$3
  local fallback_cmd=${4:-}
  if command_exists $binary; then
    alias "$alias_cmd"="$preferred_cmd"
  elif [[ ! -z "$fallback_cmd" ]]; then
    alias "$alias_cmd"="$fallback_cmd"
  fi
}
