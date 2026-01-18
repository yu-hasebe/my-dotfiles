function repo_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd
}

function log_info() {
  echo "$@" >&2
}

function log_warn() {
  echo "$@" >&2
}

function log_error() {
  echo "$@" >&2
}
