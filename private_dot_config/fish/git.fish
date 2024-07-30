# git
abbr gst "git status"
abbr gsw "git switch"
abbr gd "git diff"
abbr ga "git add"
abbr gc "git commit -v"
abbr gp "git push"
abbr gf "git fetch --prune --all"
abbr gl "git pull"
abbr gco "git checkout"
abbr glp "git pull --rebase && git push"

# github
abbr prmd "gh pr merge -d"
abbr prm "gh pr merge"
abbr prvw "gh pr view -w"
abbr prv "gh pr view"
abbr prcm "gh pr create --assignee @me"

function git_commit_with_prefix
    set branch_name (git symbolic-ref --short HEAD)
    set ticket_prefix (echo $branch_name | string match -r '^([A-Z]+-[0-9]+)')

    if test (count $argv) -gt 0
        set commit_msg $argv
    else
        set temp_file (mktemp)
        $EDITOR $temp_file
        set commit_msg (cat $temp_file)
        rm $temp_file
    end

    set commit_msg_with_prefix "$ticket_prefix: $commit_msg"
    git commit -v -m "$commit_msg_with_prefix"
end
alias gpc git_commit_with_prefix
