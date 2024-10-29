if command_exists jira; then
  function select_jira_issue() {
    local jql_query="assignee = currentUser() AND status NOT IN ('Done','Wontfix')"
    local jira_issues=$(jira issue list --jql "$jql_query" --order-by status --plain --no-headers --columns KEY,SUMMARY | fzf)
    local issue_key=$(echo "$jira_issues" | awk '{print $1}')

    echo "$issue_key"
  }

  function create_branch_from_jira() {
    local issue_key=$(select_jira_issue)

    if [[ -z "$issue_key" ]]; then
      return 1
    fi

    if [ -n "$issue_key" ]; then
      local existing_branch=$(git branch --list "$issue_key*" | head -n 1 | xargs)
      if [ -n "$existing_branch" ]; then
        echo "Branch '$existing_branch' already exists. Checking out."
        git checkout "$existing_branch"
      else
        echo "Creating new branch '$issue_key'."
        git checkout -b "$issue_key"
      fi
    else
      echo "No issue selected. Aborting branch creation."
    fi
  }
  alias cbfj="create_branch_from_jira"

  function create_tmux_session_from_jira() {
    local issue_key=$(select_jira_issue)
    if [[ -z "$issue_key" ]]; then
      return 1
    fi

    tmux has-session -t $issue_key 2>/dev/null

    if [ $? != 0 ]; then
      tmux new-session -d -s $issue_key
    fi

    tmux switch-client -t $issue_key
  }
  alias csfj="create_tmux_session_from_jira"
fi
