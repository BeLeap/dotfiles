if command_exists zellij; then
    alias j="z \$(zellij list-sessions -n | grep current | awk '{print \$1}' | sed 's/_/\//g')"

    zj() {
        if [[ -z "$1" ]]; then
            zellij a -c home
        else
            zellij a -c "$1"
        fi
    }

    zellij_tab_name_update() {
        if [[ -n $ZELLIJ ]]; then
            local current_dir=$PWD
            if [[ $current_dir == $HOME ]]; then
                current_dir="~"
            else
                current_dir=${current_dir##*/}
            fi
            command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
        fi
    }

    zellij_tab_name_update
    chpwd_functions+=(zellij_tab_name_update)

    zj_cleanup() {
        zellij list-sessions -n | grep -v current | grep -v home | awk '{print $1}' | xargs -I % zellij kill-session %
    }
fi
