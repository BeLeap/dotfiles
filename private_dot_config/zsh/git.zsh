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
fi

alias gc="git commit"
alias gst="git status"
alias gp="git push"
alias gl="git pull"
alias gsw="git switch"
alias glp="git pull --rebase && git push"
alias ga="git add"
alias gco="git checkout"
alias gd="git diff"

# gpc: git prefix commit
function gpc() {
  # 현재 브랜치 이름을 가져옵니다
  local branch_name=$(git rev-parse --abbrev-ref HEAD)

  # 브랜치 이름에서 <issue> 추출 (형식: #123 또는 ABC-1234)
  if [[ $branch_name =~ ([A-Z]+-[0-9]+|#[0-9]+) ]]; then
    local issue="${match[1]}"
  else
    echo "브랜치 이름에서 이슈 번호를 찾을 수 없습니다."
    return 1
  fi


  # 임시 파일을 사용하여 커밋 메시지를 작성
  local temp_file=$(mktemp /tmp/commit-msg.XXXXXX)

  # 이슈 번호를 커밋 메시지에 추가
  echo "[${issue}] " > $temp_file

  # git commit -v로 diff와 함께 편집기 열기
  git commit -v -e --file=$temp_file

  # 임시 파일 삭제
  rm -f $temp_file
}

