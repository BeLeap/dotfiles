if status is-interactive
    fish_vi_key_bindings

    if type -q hx
        set -x EDITOR hx
    else
        set -x EDITOR vim
    end

    alias sofish "source ~/.config/fish/config.fish"
    alias docker podman

    alias e "$EDITOR"

    alias lt "ls --tree --depth 3"

    abbr gst "git status"
    abbr gsw "git switch"
    abbr gd "git diff"
    abbr ga "git add"
    abbr gc "git commit -v"
    abbr gac "git commit -av"
    abbr gp "git push"
    abbr gf "git fetch --prune --all"
    abbr gl "git pull"
    abbr gco "git checkout"
    abbr glp "git pull --rebase && git push"

    abbr k kubectl
    abbr ktx kubectx
    abbr kns kubens

    abbr prmd "gh pr merge -d"
    abbr prm "gh pr merge"
    abbr prvw "gh pr view -w"
    abbr prv "gh pr view"
    abbr prcm "gh pr create --assignee @me"

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

    if type -q fzf
        fzf --fish | source

        if type -q fd
            set -gx FZF_DEFAULT_COMMAND 'fd --type file'
        end

        function ff
            fzf | read -l result
            $EDITOR $result
        end

        function ffd
            fzf | read -l result
            (dirname $result)
        end
    end

    if test -d ~/.asdf
        source ~/.asdf/asdf.fish
    end
end
