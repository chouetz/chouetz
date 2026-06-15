# ----------Generic useful methods ----------#
pp () {
  cd ~/workspaces/tests/scripts/python || exit
  pyenv activate
  python
}
gt() {
  cd "$(find -L ~/workspaces/"${2}" -type d -maxdepth 2 -iname "*${1}*" | sort | head -1)" || exit
}
cl() {
  # Extract worktree name from current path if in a worktree
  local title="Claude Code"
  local args=("$@")
  for ((i=1; i<=${#args[@]}; i++)); do
    if [[ "${args[$i]}" == "-w" ]]; then
      title="CC ${args[$((i+1))]}"
      break
    fi
  done
  # Set iTerm2 tab title
  echo -ne "\e]1;${title}\a"
  command claude "$@"
  # Reset title after exit
  echo -ne "\e]1;\a"
}
wt() {
  if pwd | grep -q worktree; then
    cd ../../../
  fi;
  if [ -n "$1" ]; then
    cd "$(find -L .claude/worktrees/ -type d -maxdepth 2 -iname "*${1}*" | sort | head -1)" || exit
  fi
}
pac() {
  if which -s deactivate > /dev/null 2>&1; then
    deactivate
  fi
  source venv/bin/activate
}
gdep() {
  git g "$1" | grep go.mod
}
flush_branch() {
  dry_run=$1
  git switch main
  if [ $? -eq 128 ]; then
    git switch master
  fi
  git pull
  for branch in $(git branch --format='%(refname:short)'); do
    is_remote=$(git branch -r --list "origin/${branch}")
    if [[ -z ${is_remote} ]]; then
      if [[ -n ${dry_run} ]]; then
        echo "git branch -D ${branch}"
      else
        git branch -D "${branch}"
      fi
    fi
  done
}
github_repos() {
  pattern=$(jq -rn --arg x "$1" '$x|@uri')
  curl -sH "Accept: application/vnd.github.text-match+json" -H "Authorization: Bearer $GITHUB_TOKEN" "https://api.github.com/search/code?q=$pattern&type=code" | jq ".items[].repository.html_url" | sort -u
}
for_sed() {
  for file in $(git grep "$1" | cut -d":" -f1 | sort -u); do
    sed -i "" "s/$1/$2/g" "$file";
  done
}
sortu() {
  sort -u "$1" > tmp && mv tmp "$1"
}
ptest() {
  black "$1"
  isort "$1"
  flake8 "$1"
}

# ---------- Revive specific --------#
gvi() {
  vi "$(git ls-files | grep "$1")"
}
list_rest() {
  grep "(revive)" "$1" | grep ":" | cut -d":" -f4 | sort | uniq -c
}
resort() {
  sort -t':' -k1,1 -k2,2nr "$1" > "$2"
}
get_keyword() {
   grep "$1" "$2"| grep ":" | sort -u > "$3"
}
vivi() {
  while read -r line; do
    file=$(echo "$line" | cut -d":" -f1);
    num=$(echo "$line" | cut -d":" -f2);
    echo vi +"$num" "$file";
  done < "$1"
}
