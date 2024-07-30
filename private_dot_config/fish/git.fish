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
abbr ggr "cd (git rev-parse --show-toplevel 2>/dev/null)"

# github
abbr prmd "gh pr merge -d"
abbr prm "gh pr merge"
abbr prvw "gh pr view -w"
abbr prv "gh pr view"
abbr prcm "gh pr create --assignee @me"

function git_commit_with_prefix
    set git_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$git_root"
        echo "Not a git repository."
        return 1
    end

    set branch_name (git symbolic-ref --short HEAD)
    set ticket_prefix (echo $branch_name | string match -r '^#[0-9]+|[A-Z]+-[0-9]+')

    if test (count $argv) -gt 0
        set commit_msg $argv
    else
        set divider "# ------------------------ >8 ------------------------"

        set temp_file "$git_root/.git/COMMIT_EDITMSG"
        echo "" >$temp_file
        echo "# Please enter the commit message for your changes. Lines starting" >>$temp_file
        echo "# with '#' will be ignored, and an empty message aborts the commit." >>$temp_file
        echo "#" >>$temp_file
        echo "# On branch $branch_name" >>$temp_file
        echo "#" >>$temp_file
        echo "# Changes to be committed:" >>$temp_file
        for line in (git diff --cached --name-status)
            set file_status (echo $line | awk '{print $1}')
            set file_name (echo $line | awk '{print $2}')
            switch $file_status
                case M
                    echo "# modified: $file_name" >>$temp_file
                case A
                    echo "# added: $file_name" >>$temp_file
                case D
                    echo "# deleted: $file_name" >>$temp_file
                case 'R*'
                    set dst_file_name (echo $line | awk '{print $3}')
                    echo "# renamed: $file_name -> $dst_file_name" >>$temp_file
            end
        end
        echo "#" >>$temp_file
        echo "$divider" >>$temp_file
        echo "# Do not modify or remove the line above." >>$temp_file
        echo "# Everything below it will be ignored." >>$temp_file
        echo "#" >>$temp_file
        echo "# Changes to be committed:" >>$temp_file

        git diff --cached >>$temp_file
        $EDITOR $temp_file
        set commit_msg (awk '/^'$divider'/ {exit} {print}' $temp_file | grep -v '^#')
        rm $temp_file

        if test -z "$commit_msg"
            echo "Aborting commit due to empty commit message."
            return 1
        end
    end

    if test -n "$ticket_prefix"
        set commit_msg "[$ticket_prefix] $commit_msg"
    end
    git commit -v -m "$commit_msg"
end
alias gpc git_commit_with_prefix

function create_rc_pr
    set branch (git branch --list master main | head -n 1 | awk '{print $1}')
    if test -z "$branch"
        echo "Neither master nor main branch exists."
        return 1
    end

    echo "Creating RC PR to branch: $branch"

    gh pr create --assignee @me --base $branch --title RC --body "RC "(date -u +%Y-%m-%dT%H:%M:%S)
end
alias crcpr create_rc_pr
