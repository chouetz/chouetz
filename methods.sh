# ----------Generic useful methods ----------#
pp () {
  source ~/workspaces/venv/bin/activate
  python
}
gt() {
  cd "$(find -L ~/workspaces -type d -maxdepth 2 -iname "*${1}*" | sort | head -1)" || exit
}
git_file() {
  git grep -i "$1" | cut -d ':' -f 1 | sort -u
}
pac() {
  if which -s deactivate > /dev/null 2>&1; then
    deactivate
  fi
  source venv/bin/activate
}
flush_branch() {
  dry_run=$1
  git fetch
  for branch in $(git branch --format='%(refname:short)'); do
    is_remote=$(git branch -r --list "origin/${branch}")
    if [[ -z ${is_remote} ]]; then
      if [[ -n ${dry_run} ]]; then
        echo "Remove ${branch}"
      else
        git branch -D "${branch}"
      fi
    fi
  done
}
github_repos() {
  pattern=$1
  curl -sH "Accept: application/vnd.github.text-match+json" -H "Authorization: Bearer $TOKEN" "https://api.github.com/search/code?q=$pattern&type=code" | jq ".items[].repository.html_url" | sort -u
}
for_sed() {
  for file in $(git grep "$1" | cut -d":" -f1 | sort -u); do
    sed -i "" "s/$1/$2/g" "$file";
  done
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
