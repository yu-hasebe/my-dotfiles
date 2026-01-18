#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob

source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../lib" && pwd)/common.sh"

function create_symlinks() {
  local _force=${1:-false}
  local _interactive=${2:-false}

  (
    cd "$(repo_root)/dotfiles"

    local _dotfile
    for _dotfile in .*; do
      case "${_dotfile}" in
      . | .. | .git) continue ;;
      esac

      ln_opts=(-s -v -n)
      ${_force} && ln_opts+=(-f)
      ${_interactive} && ln_opts+=(-i)

      ln "${ln_opts[@]}" "$(pwd)/${_dotfile}" "$HOME"
    done
  )
}

function main() {
  local _force _interactive

  while [[ $# -gt 0 ]]; do
    case "$1" in
    -f | --force)
      _force=true
      ;;
    -i | --interactive)
      _interactive=true
      ;;
    --)
      shift
      break
      ;;
    *)
      log_error "unknown option: $1"
      exit 1
      ;;
    esac
    shift
  done

  create_symlinks ${_force} ${_interactive}
}

main "$@"
