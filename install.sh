#!/bin/bash

# Configuration
REPO_USER="juliusmarkwei"
REPO_NAME="ghost-writer"
BRANCH="main"
SCRIPT_NAME="ghost-writer"
DOWNLOAD_URL="https://raw.githubusercontent.com/$REPO_USER/$REPO_NAME/$BRANCH/index.sh"

echo "🚀  Installing GhostWriter..."

# Detect OS
OS_NAME=$(uname -s)
echo "Detected OS: $OS_NAME"

# Determine Install Path
if [[ "$OS_NAME" == "Darwin" ]] || [[ "$OS_NAME" == "Linux" ]]; then
    # Try /usr/local/bin first (best for PATH), but fallback to user dir to avoid password
    if [[ -w "/usr/local/bin" ]]; then
        INSTALL_DIR="/usr/local/bin"
        USE_SUDO=""
    else
        # /usr/local/bin is protected, install to user's local bin
        INSTALL_DIR="$HOME/.local/bin"
        mkdir -p "$INSTALL_DIR"
        USE_SUDO=""
    fi
else
    # Windows / Git Bash
    INSTALL_DIR="$HOME/bin"
    mkdir -p "$INSTALL_DIR"
    echo "Adding $INSTALL_DIR to PATH (if not present)..."
    export PATH="$PATH:$INSTALL_DIR"
    USE_SUDO=""
fi

# Download Script
echo "Downloading..."
if command -v curl &> /dev/null; then
    $USE_SUDO curl -fsSL "$DOWNLOAD_URL" -o "$INSTALL_DIR/$SCRIPT_NAME"
elif command -v wget &> /dev/null; then
    $USE_SUDO wget -qO "$INSTALL_DIR/$SCRIPT_NAME" "$DOWNLOAD_URL"
else
    echo "❌  Error: Neither curl nor wget found."
    exit 1
fi

# Make Executable
echo "Setting permissions..."
$USE_SUDO chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Install Dependencies (Linux only)
if [[ "$OS_NAME" == "Linux" ]]; then
    if ! command -v xdotool &> /dev/null; then
        echo "Installing xdotool dependency..."
        if command -v apt-get &> /dev/null; then
            $USE_SUDO apt-get update && $USE_SUDO apt-get install -y xdotool
        elif command -v dnf &> /dev/null; then
            $USE_SUDO dnf install -y xdotool
        elif command -v pacman &> /dev/null; then
            $USE_SUDO pacman -S --noconfirm xdotool
        fi
    fi
fi

echo ""
echo "✅  Installation Complete!"
echo "    Installed to: $INSTALL_DIR/$SCRIPT_NAME"

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  WARNING: '$INSTALL_DIR' is not in your PATH."
    echo "    To run '$SCRIPT_NAME' from anywhere, add it to your PATH:"
    echo ""
    if [[ "$OS_NAME" == "Darwin" ]] || [[ "$OS_NAME" == "Linux" ]]; then
        echo "    Run this command (or add to ~/.bashrc or ~/.zshrc):"
        echo "    export PATH=\"\$PATH:$INSTALL_DIR\""
    else
        echo "    Add '$INSTALL_DIR' to your User Environment Variables (Path)."
    fi
    echo ""
fi

# Final usage instructions
echo "--------------------------------------------------------"
echo "🎉  You can now use '$SCRIPT_NAME' anywhere!"
echo "    Example: $SCRIPT_NAME --duration 10"
echo "--------------------------------------------------------"
