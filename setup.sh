#!/usr/bin/env bash
set -euo pipefail

FILES=(
	".config"
	".gitconfig"
	".tmux.conf"
	".zprofile"
	".zshrc"
)

function _install() {
	local _file
	for _file in "${FILES[@]}"; do
		ln -sf "$PWD/${_file}" "$HOME/${_file}"
		echo "🔗 Linked: ${_file}" >&2
	done

	echo "✅ All symlinks created!" >&2
}

function _uninstall() {
	local _file
	for _file in "${FILES[@]}"; do
		if [[ -L "$HOME/${_file}" ]]; then
			rm "$HOME/${_file}"
			echo "❌ Removed symlink: ${_file}" >&2
		else
			echo "⚠️ Not a symlink or does not exist: ${_file}" >&2
		fi
	done

	echo "✅ All symlinks removed!" >&2
}

function main() {
	local _subcommand="${1}"
	case "${_subcommand}" in
	install) _install ;;
	uninstall) _uninstall ;;
	*) ;;
	esac
}

main "${@}"
