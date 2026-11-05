# Shared by herdr-config and herdr-connect-wsl: where Herdr lives on the Windows side.
# Override with WIN_PROGRAMS (…/AppData/Local/Programs), HERDR_HOME or HERDR_MACHINE.
WIN_PROGRAMS="${WIN_PROGRAMS:-}"
if [ -z "$WIN_PROGRAMS" ]; then
  for exe in /mnt/c/Users/*/AppData/Local/Programs/herdr-app/herdr-app.exe; do
    [ -e "$exe" ] && WIN_PROGRAMS="${exe%/herdr-app/herdr-app.exe}" && break
  done
fi
WIN_USER_HOME="${WIN_PROGRAMS%/AppData/Local/Programs}"
HERDR_HOME="${HERDR_HOME:-$WIN_USER_HOME/.config/herdr-app}"
HERDR_MACHINE="${HERDR_MACHINE:-wsl}"
HC_EXE="$WIN_PROGRAMS/herdr-core/hc.exe"

die() { echo "error: $*" >&2; exit 1; }
need_herdr() {
  [ -n "$WIN_PROGRAMS" ] || die "Herdr isn't installed on Windows (no herdr-app.exe under /mnt/c/Users/*/AppData/Local/Programs)"
}
# Windows programs complain when started from a WSL folder; run them from C:.
win() { (cd /mnt/c && "$@"); }
