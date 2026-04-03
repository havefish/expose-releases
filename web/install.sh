#!/bin/bash
# Copyright (c) 2026 Chinmaya Panda. All rights reserved.
# Proprietary Software - Developed by Chinmaya Panda
set -e

# The public repository where releases will be hosted
REPO="havefish/expose-releases"

echo "⚡️ Installing Expose CLI..."

OS="$(uname -s)"
ARCH="$(uname -m)"

# Normalize OS string
case $OS in
  "Linux")
    OS="linux"
    ;;
  "Darwin")
    OS="darwin"
    ;;
  *)
    echo "OS $OS is not supported via this script."
    exit 1
    ;;
esac

# Normalize Architecture string
case $ARCH in
  "x86_64")
    ARCH="amd64"
    ;;
  "aarch64" | "arm64")
    ARCH="arm64"
    ;;
  *)
    echo "Architecture $ARCH is not supported via this script."
    exit 1
    ;;
esac

echo "=> Detected $OS ($ARCH)"

# Get latest release tag from GitHub API
LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$LATEST_TAG" ]; then
  echo "Error: Failed to fetch the latest release tag from GitHub."
  exit 1
fi

FILE_NAME="expose_${OS}_${ARCH}.tar.gz"
DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST_TAG/$FILE_NAME"

TMP_DIR=$(mktemp -d)
echo "=> Downloading expose $LATEST_TAG..."

curl -sL $DOWNLOAD_URL -o "$TMP_DIR/$FILE_NAME"

# Extract the tarball
tar -xzf "$TMP_DIR/$FILE_NAME" -C "$TMP_DIR"

# Install binary to ~/.expose/bin to avoid sudo requests
INSTALL_DIR="$HOME/.expose/bin"
mkdir -p "$INSTALL_DIR"

echo "=> Installing to $INSTALL_DIR..."
mv "$TMP_DIR/expose" "$INSTALL_DIR/expose"
chmod +x "$INSTALL_DIR/expose"

rm -rf "$TMP_DIR"

echo "✅ Successfully installed 'expose'."

# Try to detect shell config file
PROFILE=""
case "$SHELL" in
  */zsh) PROFILE="$HOME/.zshrc" ;;
  */bash) PROFILE="$HOME/.bashrc" ;;
  *) 
    if [ -f "$HOME/.zshrc" ]; then PROFILE="$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then PROFILE="$HOME/.profile"
    fi
    ;;
esac

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo ""
  
  if [ -n "$PROFILE" ]; then
    echo "=> Adding $INSTALL_DIR to your PATH via $PROFILE..."
    if echo "" >> "$PROFILE" && echo "# expose CLI" >> "$PROFILE" && echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$PROFILE"; then
      echo "✅ Successfully updated your path."
      echo "⚠️  NOTE: Run 'source $PROFILE' or open a new terminal for the changes to take effect."
    else
      echo "⚠️  Failed to write to $PROFILE"
      echo "   Add it manually by running: export PATH=\"\$PATH:$INSTALL_DIR\""
    fi
  else
    echo "⚠️  NOTE: $INSTALL_DIR is not in your PATH."
    echo "   Add it manually by running: export PATH=\"\$PATH:$INSTALL_DIR\""
  fi
fi


echo ""
echo "Try running 'expose -port 3000' to start tunneling!"
