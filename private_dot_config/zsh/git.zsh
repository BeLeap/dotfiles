if [[ ! -z "$(command -v gh)" ]]; then
  alias prcm="gh pr create --assignee @me"
  alias prv="gh pr view"
  alias prvw="gh pr view -w"
  alias prm="gh pr merge"
  alias prmd="gh pr merge -d"

  function create_rc_pr() {
      branch=$(git branch --list master main | head -n 1 | awk '{print $1}')
      if [ -z "$branch" ]; then
          echo "Neither master nor main branch exists."
          return 1
      fi

      echo "Creating RC PR to branch: $branch"

      gh pr create --assignee @me --base $branch --title "RC" --body "RC $(date -u +%Y-%m-%dT%H:%M:%S)"
  }
  alias crcpr="create_rc_pr"

  function create_branch_from_issue() {
    local issue_key=$(gh issue list --assignee "@me" --json "number" --json "title" | yq '.[] | "\(.number) \(.title)"' | fzf | awk '{print $1}')

    if [[ -z "$issue_key" ]]; then
      return 1
    fi

    if [ -n "$issue_key" ]; then
      local issue_key="#$issue_key"
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
  alias cbfi="create_branch_from_issue"
fi

alias gst="git status"
alias gp="git push"
alias gl="git pull"
alias gsw="git switch"
alias glp="git pull --rebase && git push"
alias ga="git add"
alias gco="git checkout"
alias gd="git diff"
alias gf="git fetch --all --prune"
alias gc="ai_commit"

function ai_commit {
  local custom_prefix="$1"
  if [[ ! -z "$1" ]]; then
    shift
  fi
  # 임시 파일을 사용하여 커밋 메시지를 작성
  local temp_file=$(mktemp /tmp/commit-msg.XXXXXX)

  local instruction='
    Write a professional git commit message based on the a diff below
    Do not preface the commit with anything, use the present tense, return the full sentence, and use the conventional commits specification.

    diff
    ```
    '$(git diff --staged --unified=0)'
    ```
  '
  local ai_commit_msg=$(ollama run llama3.2:3b "$instruction")

  # 이슈 번호를 커밋 메시지에 추가
  echo "$custom_prefix$ai_commit_msg" > $temp_file

  # git commit -v로 diff와 함께 편집기 열기
  git commit -v -e --file=$temp_file $@

  # 임시 파일 삭제
  rm -f $temp_file
}

# gpc: git prefix commit
function gpc {
  # 현재 브랜치 이름을 가져옵니다
  local branch_name=$(git rev-parse --abbrev-ref HEAD)

  # 브랜치 이름에서 <issue> 추출 (형식: #123 또는 ABC-1234)
  if [[ $branch_name =~ ([A-Z]+-[0-9]+|#[0-9]+) ]]; then
    local issue="${match[1]}"
  else
    echo "브랜치 이름에서 이슈 번호를 찾을 수 없습니다."
    return 1
  fi

  ai_commit "[${issue}] "
}

ggr() {
  local git_root
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ -n "$git_root" ]; then
    cd "$git_root"
  else
    echo "No git root found"
  fi
}
