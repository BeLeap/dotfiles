if command_exists jira; then
  function create_branch_from_jira() {
    local jql_query="assignee = currentUser() AND status IN ('To Do', 'In Progress', 'In Review')"
    local jira_issues=$(jira issue list --jql "$jql_query" --plain --no-headers --columns KEY,SUMMARY | fzf)
    local issue_key=$(echo "$jira_issues" | awk '{print $1}')

    if [ -n "$issue_key" ]; then
      git checkout -b "$issue_key"
    else
      echo "No issue selected. Aborting branch creation."
    fi
  }
  alias cbfj="create_branch_from_jira"
fi
