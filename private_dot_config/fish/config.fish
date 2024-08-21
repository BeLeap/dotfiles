if status is-interactive
    fish_vi_key_bindings

    if type -q hx
        set -x EDITOR hx
    else
        set -x EDITOR vim
    end

    set -x FZF_EXISTS false
    if type -q fzf
        set -x FZF_EXISTS true
    end

    if test -d ~/.asdf
        source ~/.asdf/asdf.fish
    end

    alias sofish "source ~/.config/fish/config.fish"
    alias docker podman

    alias e "$EDITOR"

    source ~/.config/fish/git.fish

    alias lt "ls --tree --depth 3"

    alias k kubectl
    alias ktx kubectx
    alias kns kubens
    alias ku k9s
    alias kh "k9s --headless"

    abbr tf terraform

    if type -q starship
        starship init fish | source
    end
    if type -q zoxide
        zoxide init fish | source
    end
    if type -q lsd
        alias ls "lsd --group-directories-first"
        alias ll "lsd --group-directories-first -l"
        alias lla "lsd --group-directories-first -la"
    end

    if type -q direnv
        direnv hook fish | source
    end

    if type -q carapace
        carapace _carapace | source
    end

    if $FZF_EXISTS
        fzf --fish | source

        if type -q fd
            set -gx FZF_DEFAULT_COMMAND 'fd --type file'
        end

        function ff
            fzf | read -l result

            if test -z "$result"
                echo "empty result"
            else
                $EDITOR $result
            end
        end

        function ffd
            fzf | read -l result

            if test -z "$result"
                echo "empty result"
            else
                cd (dirname $result)
            end
        end
    end
end
