#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob

source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../lib" && pwd)/common.sh"

function main() {
  local _force="${1:-}"
  local _dotfile

  (
    cd "$(repo_root)/dotfiles"

    for _dotfile in .*; do
      case "${_dotfile}" in
      . | .. | .git) continue ;;
      *)
        if [[ "${_force}" == "force" ]]; then
          ln -sfivn "$(pwd)/${_dotfile}" "${HOME}"
        else
          ln -svn "$(pwd)/${_dotfile}" "${HOME}"
        fi
        ;;
      esac
    done
  )
}

main "$@"
