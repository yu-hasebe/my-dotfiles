#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob

function main() {
  local _force="${1:-}"
  local _dotfile

  (
    cd dotfiles

    for _dotfile in .*; do
      case "${_dotfile}" in
      . | .. | .git) continue ;;
      *)
        if [[ "${_force}" == "force" ]]; then
          ln -sfivn "${PWD}/${_dotfile}" "${HOME}"
        else
          ln -svn "${PWD}/${_dotfile}" "${HOME}"
        fi
        ;;
      esac
    done
  )
}

main "$@"
