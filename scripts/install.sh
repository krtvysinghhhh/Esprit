#!/usr/bin/env sh
# Esprit one-line installer for Linux & macOS terminals
# Usage: curl -fsSL https://raw.githubusercontent.com/krtvysinghhhh/Esprit/main/scripts/install.sh | sh
set -eu

REPO="krtvysinghhhh/Esprit"
VERSION="${ESPRIT_VERSION:-latest}"

# ── Detect Target Architecture & Platform ─────────────────────────────────────
OS="$(uname -s)"
ARCH="$(uname -m)"

case "${OS}" in
  Darwin)
    case "${ARCH}" in
      arm64)  TARGET="aarch64-apple-darwin" ;;
      x86_64) TARGET="x86_64-apple-darwin"  ;;
      *) echo "Unsupported macOS arch: ${ARCH}" && exit 1 ;;
    esac
    ;;
  Linux)
    case "${ARCH}" in
      x86_64)  TARGET="x86_64-unknown-linux-musl"  ;;
      aarch64) TARGET="aarch64-unknown-linux-musl" ;;
      armv7l)  TARGET="armv7-unknown-linux-musleabihf" ;;
      *) echo "Unsupported Linux arch: ${ARCH}" && exit 1 ;;
    esac
    ;;
  *)
    echo "Unsupported operating system: ${OS}"
    echo "For Windows, run in PowerShell:"
    echo "  irm https://raw.githubusercontent.com/${REPO}/main/scripts/install.ps1 | iex"
    exit 1
    ;;
esac

# ── Select Install Directory ──────────────────────────────────────────────────
if [ -n "${ESPRIT_INSTALL_DIR:-}" ]; then
  BIN_DIR="${ESPRIT_INSTALL_DIR}"
elif [ -w "/usr/local/bin" ]; then
  BIN_DIR="/usr/local/bin"
elif [ -d "${HOME}/.local/bin" ] || mkdir -p "${HOME}/.local/bin" 2>/dev/null; then
  BIN_DIR="${HOME}/.local/bin"
else
  BIN_DIR="/usr/local/bin"
fi

mkdir -p "${BIN_DIR}" 2>/dev/null || true

# ── Resolve Version ───────────────────────────────────────────────────────────
if [ "${VERSION}" = "latest" ]; then
  RELEASE_API="https://api.github.com/repos/${REPO}/releases/latest"
  if command -v curl >/dev/null 2>&1; then
    TAG="$(curl -fsSL "${RELEASE_API}" 2>/dev/null | grep '"tag_name"' | sed 's/.*"tag_name": *"v\([^"]*\)".*/\1/' || true)"
  elif command -v wget >/dev/null 2>&1; then
    TAG="$(wget -qO- "${RELEASE_API}" 2>/dev/null | grep '"tag_name"' | sed 's/.*"tag_name": *"v\([^"]*\)".*/\1/' || true)"
  else
    TAG=""
  fi
  VERSION="${TAG:-0.1.0}"
fi

echo ""
echo "  ███████╗███████╗██████╗ ██████╗ ██╗████████╗"
echo "  ██╔════╝██╔════╝██╔══██╗██╔══██╗██║╚══██╔══╝"
echo "  █████╗  ███████╗██████╔╝██████╔╝██║   ██║   "
echo "  ██╔══╝  ╚════██║██╔═══╝ ██╔══██╗██║   ██║   "
echo "  ███████╗███████║██║     ██║  ██║██║   ██║   "
echo ""
echo "  Installing Esprit v${VERSION} (${TARGET}) into ${BIN_DIR}…"

# ── Download or Build ─────────────────────────────────────────────────────────
URL="https://github.com/${REPO}/releases/download/v${VERSION}/esprit-${TARGET}.tar.gz"
TMPDIR="$(mktemp -d 2>/dev/null || mktemp -d -t 'esprit')"
TARBALL="${TMPDIR}/esprit.tar.gz"
DOWNLOADED=0

if command -v curl >/dev/null 2>&1; then
  if curl -fsSL --progress-bar "${URL}" -o "${TARBALL}" 2>/dev/null; then
    DOWNLOADED=1
  fi
elif command -v wget >/dev/null 2>&1; then
  if wget -q --show-progress "${URL}" -O "${TARBALL}" 2>/dev/null; then
    DOWNLOADED=1
  fi
fi

if [ "${DOWNLOADED}" -eq 1 ]; then
  tar -xzf "${TARBALL}" -C "${TMPDIR}"
  rm -f "${TARBALL}"

  if [ -w "${BIN_DIR}" ]; then
    mv "${TMPDIR}/esprit" "${BIN_DIR}/esprit"
  else
    sudo mv "${TMPDIR}/esprit" "${BIN_DIR}/esprit"
  fi
  chmod +x "${BIN_DIR}/esprit"
  rm -rf "${TMPDIR}"
else
  # Fallback to source compilation if precompiled binary is not yet published
  if command -v cargo >/dev/null 2>&1; then
    echo "  • Building from source using Cargo..."
    cargo install --git "https://github.com/${REPO}.git" esprit-cli --root "${HOME}/.esprit" --quiet
    mkdir -p "${BIN_DIR}"
    cp -f "${HOME}/.esprit/bin/esprit" "${BIN_DIR}/esprit"
    chmod +x "${BIN_DIR}/esprit"
  else
    echo "  ✗ Could not download pre-compiled release binary and Cargo is not installed."
    echo "    Please install Rust via https://rustup.rs or download from:"
    echo "    https://github.com/${REPO}/releases"
    exit 1
  fi
fi

# ── Path Warning Check ────────────────────────────────────────────────────────
case ":${PATH}:" in
  *":${BIN_DIR}:"*) ;;
  *)
    echo ""
    echo "  ⚠ Note: ${BIN_DIR} is not in your current PATH."
    echo "    Add this to your ~/.zshrc or ~/.bashrc:"
    echo "      export PATH=\"${BIN_DIR}:\$PATH\""
    ;;
esac

echo ""
echo "  ✓ Esprit v${VERSION} installed successfully to ${BIN_DIR}/esprit"
echo ""
echo "  Quick Start:"
echo "    esprit doctor             # Full system and AI health check"
echo "    esprit clean --dry-run    # Preview storage and cache cleanup"
echo "    esprit ask <question>     # Query codebase with semantic intelligence"
echo "    esprit --help             # Command catalog"
echo ""
