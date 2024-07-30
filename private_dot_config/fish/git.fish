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
        echo "" >>$temp_file
        echo "# ------------------------ >8 ------------------------" >>$temp_file
        echo "# Please enter the commit message for your changes. Lines starting" >>$temp_file
        echo "# with '#' will be ignored, and an empty message aborts the commit." >>$temp_file
        echo "#" >>$temp_file
        echo "# On branch $branch_name" >>$temp_file
        echo "#" >>$temp_file
        echo "# Changes to be committed:" >>$temp_file
        git diff --cached | sed 's/^/# /' >>$temp_file
        echo "# ------------------------ >8 ------------------------" >>$temp_file
        $EDITOR $temp_file
        set commit_msg (grep -v '^#' $temp_file)
        rm $temp_file

        if test -z "$commit_msg"
            echo "Aborting commit due to empty commit message."
            return 1
        end
    end

    set commit_msg_with_prefix "[$ticket_prefix] $commit_msg"
    git commit -v -m "$commit_msg_with_prefix"
end
alias gpc git_commit_with_prefix
