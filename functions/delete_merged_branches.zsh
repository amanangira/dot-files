_delete_merged_branches_help() {
    printf '%s\n' \
      'Usage:' \
      '  delete_merged_branches [base_branch]' \
      '' \
      'Deletes local branches that are already merged into the given base branch.' \
      '' \
      'Arguments:' \
      '  base_branch    Base branch to compare against. Defaults to develop.' \
      '' \
      'Examples:' \
      '  delete_merged_branches' \
      '  delete_merged_branches develop' \
      '  delete_merged_branches main' \
      '' \
      'Notes:' \
      '  - Must be run inside a git repository.' \
      '  - Prompts before deleting anything.' \
      '  - Uses git branch -d, so Git refuses unsafe deletions.' \
      '  - Excludes the base branch, current branch, main, and master.'
  }

delete_merged_branches() {
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
      echo "Not inside a git repository."
      return 1
    }

    current_branch="$(git -C "$repo_root" branch --show-current)"

    git -C "$repo_root" rev-parse --verify "$base" >/dev/null 2>&1 || {
      echo "Base branch '$base' does not exist locally."
      echo "Try: git fetch origin $base:$base"
      return 1
    }

    branches=$(
      git -C "$repo_root" branch --format='%(refname:short)' --merged "$base" |
        grep -vE "^(${base}|${current_branch}|main|master)$"
    )

    if [[ -z "$branches" ]]; then
      echo "No local branches already merged into '$base'."
      return 0
    fi

    echo "Local branches merged into '$base':"
    echo "$branches"

    printf "\nDelete these local branches? [y/N] "
    read -r confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
      echo "$branches" | xargs git -C "$repo_root" branch -d
    else
      echo "Aborted."
    fi
  }