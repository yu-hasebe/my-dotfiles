#!/usr/bin/env bash
set -euo pipefail

function _files() {
	local _files=(
		".config"
		".gitconfig"
		".tmux.conf"
		".zprofile"
		".zshrc"
	)

	printf "%s\n" "${_files[@]}"
}

function _install() {
	local _force="${1}"
	shift
	local _files=("${@}")

	local _file _target
	for _file in "${_files[@]}"; do
		_target="$HOME/${_file}"

		if [[ -e "${_target}" || -L "${_target}" ]]; then
			if [[ "${_force}" -eq 1 ]]; then
				rm -rf "${_target}"
				echo "⚡ Overwriting existing: ${_file}" >&2
			else
				echo "⚠️ Skipping ${_file}, already exists: ${_target}" >&2
				continue
			fi
		fi

		ln -sf "$PWD/${_file}" "${_target}"
		echo "🔗 Linked: ${_file}" >&2
	done

	echo "✅ All symlinks created!" >&2
}

function _uninstall() {
	local _files=("${@}")

	local _file
	for _file in "${_files[@]}"; do
		if [[ -L "$HOME/${_file}" ]]; then
			rm "$HOME/${_file}"
			echo "❌ Removed symlink: ${_file}" >&2
		else
			echo "⚠️ Not a symlink or does not exist: ${_file}" >&2
		fi
	done

	echo "✅ All symlinks removed!" >&2
}

function _show_help() {
	local _files=()
	while IFS= read -r _file; do
		_files+=("${_file}")
	done < <(_files)

	echo "Usage: ${0} [-h] [-f] [install|uninstall]"
	echo ""
	echo "Commands:"
	echo "  install   Creates symlinks at $HOME"
	echo "  uninstall Removes symlinks at $HOME"
	echo "Target files:"
	echo "$(printf -- "  - %s\n" "${_files[@]}")"
	echo "Options:"
	echo "  -h        Shows this help message"
	echo "  -f        Forcibly overwrites exsiting files or directories when creating symlinkns (install only)"
	echo "  -t        Specifies the target files or directories to be replaced with symlinks"
}

function main() {
	local _force=0 _help=0 _targets=() _parsing_target=0 _subcommand=""
	while [[ "${#}" -gt 0 ]]; do
		case "${1}" in
		-h)
			_parsing_target=0
			_help=1
			;;
		-f)
			_parsing_target=0
			_force=1
			;;
		-t)
			_parsing_target=1
			;;
		install | uninstall)
			_parsing_target=0
			_subcommand="${1}"
			;;
		*)
			if [[ "${_parsing_target}" -eq 1 ]]; then
				_targets+=("${1}")
			else
				echo "invalid args: ${1}" >&2
				return 1
			fi
			;;
		esac
		shift
	done

	if [[ "${_help}" -eq 1 ]]; then
		_show_help
		return 0
	fi

	if [[ "${#_targets[@]}" -eq 0 ]]; then
		while IFS= read -r _file; do
			_targets+=("${_file}")
		done < <(_files)
	fi

	case "${_subcommand}" in
	install) _install "${_force}" "${_targets[@]}" ;;
	uninstall) _uninstall "${_targets[@]}" ;;
	*)
		echo "invalid subcommand: ${_subcommand}"
		return 1
		;;
	esac
}

main "${@:-}"
