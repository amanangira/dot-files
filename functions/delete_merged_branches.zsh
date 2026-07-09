_delete_merged_branches_help() {
  printf '%s\n' \
    "${bold}Usage:${reset}" \
    "  ${cyan}delete_merged_branches${reset} [base_branch]" \
    '' \
    'Deletes local branches that are already merged into the given base branch.' \
    '' \
    "${bold}Arguments:${reset}" \
    "  ${yellow}base_branch${reset}    Base branch to compare against. Defaults to ${green}develop${reset}." \
    '' \
    "${bold}Examples:${reset}" \
    "  ${cyan}delete_merged_branches${reset}" \
    "  ${cyan}delete_merged_branches${reset} develop" \
    "  ${cyan}delete_merged_branches${reset} main" \
    '' \
    "${bold}Notes:${reset}" \
    '  - Must be run inside a git repository.' \
    '  - Prompts before deleting anything.' \
    "  - Uses ${yellow}git branch -d${reset}, so Git refuses unsafe deletions." \
    '  - Excludes the base branch, current branch, main, and master.'
}

delete_merged_branches() {
  local reset bold dim red green yellow blue cyan
  reset="$(tput sgr0 2>/dev/null || true)"
  bold="$(tput bold 2>/dev/null || true)"
  dim="$(tput dim 2>/dev/null || true)"
  red="$(tput setaf 1 2>/dev/null || true)"
  green="$(tput setaf 2 2>/dev/null || true)"
  yellow="$(tput setaf 3 2>/dev/null || true)"
  blue="$(tput setaf 4 2>/dev/null || true)"
  cyan="$(tput setaf 6 2>/dev/null || true)"

  local base="develop"
  local repo_root
  local current_branch
  local branches
  local confirm

  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    _delete_merged_branches_help
    return 0
  fi

  if [[ -n "$1" ]]; then
    base="$1"
  fi

  repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    printf '%s\n' "${red}Error:${reset} not inside a git repository."
    return 1
  }

  current_branch="$(git -C "$repo_root" branch --show-current)"

  git -C "$repo_root" rev-parse --verify "$base" >/dev/null 2>&1 || {
    printf '%s\n' "${red}Error:${reset} base branch '${yellow}${base}${reset}' does not exist locally."
    printf '%s\n' "${dim}Try:${reset} git fetch origin ${base}:${base}"
    return 1
  }

  branches=$(
    git -C "$repo_root" branch --format='%(refname:short)' --merged "$base" |
      grep -vE "^(${base}|${current_branch}|main|master)$"
  )

  if [[ -z "$branches" ]]; then
    printf '%s\n' "${green}Done:${reset} no local branches already merged into '${yellow}${base}${reset}'."
    return 0
  fi

  printf '%s\n' "${bold}${blue}Local branches merged into '${base}':${reset}"
  printf '%s\n' "$branches" | sed "s/^/  ${cyan}/; s/$/${reset}/"

  printf '\n%s' "${yellow}Delete these local branches?${reset} ${dim}[y/N]${reset} "
  read -r confirm

  if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    printf '%s\n' "${blue}Deleting branches...${reset}"
    printf '%s\n' "$branches" | xargs git -C "$repo_root" branch -d
  else
    printf '%s\n' "${dim}Aborted.${reset}"
  fi
}