if command_exists jira; then
  function create_branch_from_jira() {
    # JQL을 사용해 원하는 티켓 리스트를 가져옵니다.
    # 여기서는 현재 할당된 티켓들을 예로 들었습니다.
    local jql_query="assignee = currentUser() AND status IN ('To Do', 'In Progress', 'In Review')"

    # JIRA 티켓 리스트를 JSON 형식으로 가져옵니다.
    local jira_issues=$(jira issue list --jql "$jql_query" --plain --no-headers --columns KEY,SUMMARY | fzf)

    # 선택된 티켓의 키(ID)를 추출합니다.
    local issue_key=$(echo "$jira_issues" | awk '{print $1}')

    # 브랜치 이름을 설정합니다 (예: feature/ISSUE-123-description).
    if [ -n "$issue_key" ]; then
      git checkout -b "$issue_key"
    else
      echo "No issue selected. Aborting branch creation."
    fi
  }
  alias cbfj="create_branch_from_jira"
fi
