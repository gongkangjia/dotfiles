# ====== Colors using tput (more compatible across terminals) ======
bold=$(tput bold)
reset=$(tput sgr0)
blue=$(tput setaf 153)
steel_blue=$(tput setaf 67)
green=$(tput setaf 71)
orange=$(tput setaf 166)
red=$(tput setaf 167)
white=$(tput setaf 15)
yellow=$(tput setaf 228)

# ====== Determine user and host style ======
if [[ "${USER}" == "root" ]]; then
  userStyle="${red}"
else
  userStyle="${orange}"
fi

if [[ -n "${SSH_TTY}" ]]; then
  hostStyle="${bold}${red}"
else
  hostStyle="${yellow}"
fi

# ====== Virtual environment name ======
prompt_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_name=$("$VIRTUAL_ENV"/bin/python -V)
    #local venv_name=$(basename "$VIRTUAL_ENV")
    echo -n "%{$steel_blue%}(${venv_name})%{$reset%}"
  fi
}

# ====== Git prompt ======
prompt_git() {
  local git_status=''
  local branchName=''

  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local gitSummary=$(git status --porcelain)

    [[ -n $(echo "$gitSummary" | grep '^M') ]] && git_status+='+'
    [[ -n $(echo "$gitSummary" | grep '^ M') ]] && git_status+='!'
    [[ -n $(echo "$gitSummary" | grep '^\?\?') ]] && git_status+='?'
    git rev-parse --verify refs/stash &>/dev/null && git_status+='$'

    branchName="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo '(unknown)')"
    [ -n "${git_status}" ] && git_status=" [${git_status}]"

    echo -n " %{$white%}on %{$blue%}${branchName}${git_status}%{$reset%}"
  fi
}

# ====== Build prompt dynamically ======
build_prompt() {
  local venv_part=$(prompt_venv)
  local git_part=$(prompt_git)

  PROMPT=""
  [[ -n "$venv_part" ]] && PROMPT+=$'\n'"${venv_part}"
  PROMPT+=$'\n'"%{${bold}%}%{${userStyle}%}%n%{${white}%} at %{${hostStyle}%}%m"
  PROMPT+="%{${white}%} in %{${green}%}%~"
  PROMPT+="${git_part}"
  PROMPT+=$'\n'"%{${white}%}\$ %{${reset}%}"
}

# Hook into precmd (runs before every prompt)
precmd() {
  build_prompt
}

# Set secondary prompt
PS2="%{${yellow}%}→ %{${reset}%}"

