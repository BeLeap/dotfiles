if command_exists jira; then
  function create_branch_from_jira() {
    local jql_query="assignee = currentUser() AND status NOT IN ('Done')"
    local jira_issues=$(jira issue list --jql "$jql_query" --plain --no-headers --columns KEY,SUMMARY | fzf)
    local issue_key=$(echo "$jira_issues" | awk '{print $1}')

    if [ -n "$issue_key" ]; then
      local existing_branch=$(git branch --list "$issue_key*" | head -n 1)
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
fi
