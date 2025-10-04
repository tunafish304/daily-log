#!/bin/bash

# ┌────────────────────────────────────────────┐
# │ VS Code Extension Installer                │
# └────────────────────────────────────────────┘
# This script installs essential VS Code extensions for Python dev.
# It detects platform and scopes extensions appropriately.
# Safe to run multiple times (idempotent).

# ─── Dry-run safety ──────────────────────────
set -e  # Exit on error
trap 'echo "Something went wrong. Try rerunning or ask for help."' ERR

# ─── Shared Extensions ───────────────────────
SHARED_EXTENSIONS=(
  ms-python.python
  ms-python.vscode-pylance
  ms-toolsai.jupyter
  ms-python.black-formatter
  ms-python.debugpy
  ms-python.vscode-python-envs
  github.copilot
  github.copilot-chat
  github.vscode-pull-request-github
  kevinrose.vsc-python-indent
)

## ─── WSL-only Extensions ─────────────────────
WSL_EXTENSIONS=(
  ms-vscode-remote.remote-wsl
)

# ─── Install Function ────────────────────────
install_extensions() {
  for ext in "${@}"; do
    echo "Installing: $ext"
    code --install-extension "$ext" || echo "Already installed or failed: $ext"
  done
}

# ─── Platform Detection ──────────────────────
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
  echo "Detected WSL environment"
  install_extensions "${WSL_EXTENSIONS[@]}"
  install_extensions "${SHARED_EXTENSIONS[@]}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Detected macOS environment"
  install_extensions "${SHARED_EXTENSIONS[@]}"
else
  echo "Detected Windows (outside WSL)"
  echo "Please run this script inside WSL for proper setup."
fi