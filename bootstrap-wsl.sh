#!/usr/bin/env bash

set -euo pipefail

readonly NVIM_VERSION="v0.12.3"
readonly DOTNET_VERSION="10.0.400"

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
local_bin="$HOME/.local/bin"
nvim_root="$HOME/.local/opt/nvim-$NVIM_VERSION"

if [[ ! -r /proc/version ]] || ! grep -qi microsoft /proc/version; then
  echo "This installer is intended for Ubuntu under WSL2." >&2
  exit 1
fi

if [[ "$script_dir" != "$config_dir" ]]; then
  echo "Clone this repository to $config_dir, then run bootstrap-wsl.sh there." >&2
  exit 1
fi

if ! command -v node >/dev/null || ! command -v npm >/dev/null; then
  echo "Node.js and npm must already be available in this shell." >&2
  echo "Load your existing nvm environment, then rerun this script." >&2
  exit 1
fi

echo "Installing Ubuntu dependencies..."
sudo apt-get update
sudo apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  git \
  imagemagick \
  ripgrep \
  unzip \
  xclip

mkdir -p "$local_bin" "$HOME/.local/opt"

if [[ ! -x "$nvim_root/bin/nvim" ]]; then
  archive="$(mktemp --suffix=.tar.gz)"
  extract_dir="$(mktemp -d)"
  trap 'rm -f "$archive"; rm -rf "$extract_dir"' EXIT

  echo "Installing Neovim $NVIM_VERSION..."
  curl --fail --location --output "$archive" \
    "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz"
  tar -xzf "$archive" -C "$extract_dir"
  mv "$extract_dir/nvim-linux-x86_64" "$nvim_root"
fi

if [[ -e "$local_bin/nvim" && ! -L "$local_bin/nvim" ]]; then
  echo "$local_bin/nvim exists and is not a symlink. Move it, then rerun this script." >&2
  exit 1
fi
ln -sfn "$nvim_root/bin/nvim" "$local_bin/nvim"

dotnet_root="$HOME/.dotnet"
if [[ ! -x "$dotnet_root/dotnet" ]] || [[ "$($dotnet_root/dotnet --version)" != "$DOTNET_VERSION" ]]; then
  dotnet_installer="$(mktemp)"
  echo "Installing .NET SDK $DOTNET_VERSION..."
  curl --fail --location --output "$dotnet_installer" https://dot.net/v1/dotnet-install.sh
  bash "$dotnet_installer" --version "$DOTNET_VERSION" --install-dir "$dotnet_root"
  rm -f "$dotnet_installer"
fi

shell_marker='# Neovim workstation bootstrap'
if ! grep -Fq "$shell_marker" "$HOME/.bashrc"; then
  printf '\n%s\n' "$shell_marker" >> "$HOME/.bashrc"
  printf 'export PATH="$HOME/.local/bin:$HOME/.dotnet:$PATH"\n' >> "$HOME/.bashrc"
  printf 'export DOTNET_ROOT="$HOME/.dotnet"\n' >> "$HOME/.bashrc"
fi

export DOTNET_ROOT="$dotnet_root"
export PATH="$local_bin:$dotnet_root:$PATH"

echo "Restoring plugins from lazy-lock.json..."
nvim --headless "+Lazy! restore" +qa

echo "Installing pinned Mason tools..."
nvim --headless "+MasonToolsInstallSync" +qa

echo
echo "Installed and detected:"
nvim --version | head -n 1
node --version
dotnet --version
echo
echo "Open a new WSL shell, then run nvim. Inside Neovim, run :checkhealth."
