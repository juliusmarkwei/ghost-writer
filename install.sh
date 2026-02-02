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
    curl -fsSL "$DOWNLOAD_URL" -o "$INSTALL_DIR/$SCRIPT_NAME"
elif command -v wget &> /dev/null; then
    wget -qO "$INSTALL_DIR/$SCRIPT_NAME" "$DOWNLOAD_URL"
else
    echo "❌  Error: Neither curl nor wget found."
    exit 1
fi

# Check download success
if [[ ! -f "$INSTALL_DIR/$SCRIPT_NAME" ]]; then
    echo "❌  Error: Failed to download script."
    exit 1
fi

# Make Executable
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Install Dependencies
echo ""
echo "📦  Checking and installing dependencies..."

# macOS Dependencies
if [[ "$OS_NAME" == "Darwin" ]]; then
    # Check Python3 (needed for mouse position detection)
    if ! command -v python3 &> /dev/null; then
        echo "⚠️  Python3 not found. Attempting to install via Homebrew..."

        # Check if Homebrew is installed
        if ! command -v brew &> /dev/null; then
            echo "Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        if command -v brew &> /dev/null; then
            brew install python3
            echo "✅  Python3 installed successfully."
        else
            echo "❌  Could not install Python3. Please install it manually."
            echo "    Visit: https://www.python.org/downloads/"
        fi
    else
        echo "✅  Python3 is already installed."
    fi

    # Check osascript (should be built-in)
    if ! command -v osascript &> /dev/null; then
        echo "❌  Error: osascript not found (unexpected on macOS)."
    else
        echo "✅  osascript found."
    fi

# Linux Dependencies
elif [[ "$OS_NAME" == "Linux" ]]; then
    # Install xdotool
    if ! command -v xdotool &> /dev/null; then
        echo "⚠️  'xdotool' not found. Attempting to install..."

        # Detect package manager and install
        if command -v apt-get &> /dev/null; then
            echo "Using apt-get..."
            sudo apt-get update && sudo apt-get install -y xdotool
        elif command -v dnf &> /dev/null; then
            echo "Using dnf..."
            sudo dnf install -y xdotool
        elif command -v pacman &> /dev/null; then
            echo "Using pacman..."
            sudo pacman -S --noconfirm xdotool
        elif command -v yum &> /dev/null; then
            echo "Using yum..."
            sudo yum install -y xdotool
        elif command -v zypper &> /dev/null; then
            echo "Using zypper..."
            sudo zypper install -y xdotool
        else
            echo "❌  Could not detect package manager."
            echo "    Please install 'xdotool' manually:"
            echo "    - Debian/Ubuntu: sudo apt-get install xdotool"
            echo "    - Fedora: sudo dnf install xdotool"
            echo "    - Arch: sudo pacman -S xdotool"
            exit 1
        fi

        # Verify installation
        if command -v xdotool &> /dev/null; then
            echo "✅  'xdotool' installed successfully."
        else
            echo "❌  Failed to install 'xdotool'."
            exit 1
        fi
    else
        echo "✅  'xdotool' is already installed."
    fi

# Windows Dependencies
else
    # Check PowerShell
    if ! command -v powershell.exe &> /dev/null; then
        echo "❌  Error: PowerShell not found."
        echo "    This script requires PowerShell for Windows."
        exit 1
    else
        echo "✅  PowerShell found."
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
        SHELL_CONFIG=""
        if [[ -f "$HOME/.zshrc" ]]; then
            SHELL_CONFIG="$HOME/.zshrc"
        elif [[ -f "$HOME/.bashrc" ]]; then
            SHELL_CONFIG="$HOME/.bashrc"
        elif [[ -f "$HOME/.bash_profile" ]]; then
            SHELL_CONFIG="$HOME/.bash_profile"
        fi

        if [[ -n "$SHELL_CONFIG" ]]; then
            echo "    Run this command to add to your shell config:"
            echo "    echo 'export PATH=\"\$PATH:$INSTALL_DIR\"' >> $SHELL_CONFIG"
            echo "    source $SHELL_CONFIG"
        else
            echo "    Add this to your shell config file (~/.bashrc or ~/.zshrc):"
            echo "    export PATH=\"\$PATH:$INSTALL_DIR\""
        fi
    else
        echo "    Add '$INSTALL_DIR' to your User Environment Variables (Path)."
    fi
    echo ""
fi

# macOS Accessibility Permissions Notice
if [[ "$OS_NAME" == "Darwin" ]]; then
    echo ""
    echo "📝  IMPORTANT: macOS Accessibility Permissions"
    echo "    When you first run $SCRIPT_NAME, you may need to grant permissions:"
    echo "    1. Go to System Settings > Privacy & Security > Accessibility"
    echo "    2. Allow your Terminal app to control your computer"
    echo "    3. This is required for keystroke simulation"
    echo ""
fi

# Final usage instructions
echo "--------------------------------------------------------"
echo "🎉  You can now use '$SCRIPT_NAME'!"
echo ""
echo "    Examples:"
echo "    $SCRIPT_NAME --duration 10"
echo "    $SCRIPT_NAME --source src/main.ts"
echo "    $SCRIPT_NAME --source src/ --duration 60"
echo ""
echo "    For help: $SCRIPT_NAME --help"
echo "--------------------------------------------------------"
