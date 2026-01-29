# GhostWriter

> **📍 You are on the `vs-code` branch** - This version uses VS Code (experimental)
>
> ⚠️ **IMPORTANT:** This branch requires VS Code settings configuration (see Prerequisites below)
>
> **Other options:**
> - **[`main`](https://github.com/juliusmarkwei/ghost-writer/tree/main)** - Vim (default, recommended)
> - **[`nano`](https://github.com/juliusmarkwei/ghost-writer/tree/nano)** - Nano (simpler)
>
> See [BRANCHES.md](https://github.com/juliusmarkwei/ghost-writer/blob/main/BRANCHES.md) for comparison

A cross-platform CLI tool that simulates a developer typing code in real-time with sophisticated human-like behavior. It reads source files from your project and "types" them into VS Code, complete with context-aware typing speeds, intelligent pauses, and even occasional typos—perfect for demonstrations, tutorials, or just having fun watching code write itself naturally.

## ✨ Features

### 🎨 Human-Like Typing

-   **Context-Aware Speed**: Automatically adjusts typing speed based on character type
    -   Fast on whitespace (2x faster)
    -   Slower on special characters like brackets and semicolons (+30-50ms)
    -   Natural variation with random jitter (±20ms per character)
-   **Intelligent Pauses**: Smart pause system that mimics real developer behavior
    -   Long pauses (1.5-4s) before major constructs (functions, classes, imports)
    -   Medium pauses (0.8-2s) after block endings
    -   Short pauses (0.3-0.8s) after blank lines
    -   Micro-pauses (0.1-0.3s) for natural rhythm
-   **Typo Simulation**: Occasional typos (~5% chance) with realistic backspace and correction
    -   Types 2-4 characters, realizes "mistake", pauses briefly
    -   Backtracks and retypes correctly
    -   Never breaks code structure (only in safe zones)
-   **VS Code Auto-Complete Handling**: Seamlessly manages VS Code's bracket/quote auto-completion
-   **Browser Search Integration**: Periodically opens browser to search for programming topics with realistic interaction
    -   Contextual searches based on what's being typed (functions, classes, imports)
    -   **Uses your default browser** (Chrome, Safari, Firefox, Edge, or any other)
    -   **Realistic browsing behavior**: Opens search → scrolls results (2-4 times) → clicks first link → scrolls article (4-7 times) → reads for 3-7s → minimizes browser → refocuses editor
    -   Triggers at natural pause points (~25% of long/medium pauses)
    -   Respects 60-second cooldown to avoid spam
    -   Total interaction time: 12-22 seconds per search
    -   Enabled by default (can be disabled with `--disable-browser-search`)

### 🛡️ Safety & Control

-   **Mouse Movement Detection**: Instantly stops when you move your mouse
-   **Smart Focus Management**: Only types into VS Code, never in other applications
-   **Graceful Cleanup**: Proper signal handling, no zombie processes

### 🚀 Workflow Features

-   **Directory & File Support**: Process entire directories or individual files
-   **Automated Workflow**: Opens files in VS Code and starts typing automatically
-   **Looping Mode**: Runs continuously for a specified duration (default 30 minutes)
-   **Language Agnostic**: Works with any programming language or text file
-   **Built-in Test Source**: Comprehensive TypeScript test content included
-   **Cross-Platform Support**: macOS, Linux, and Windows

## 📋 Prerequisites

### All Platforms

-   **VS Code**: Must be installed with the `code` command in your PATH
    -   Download from [https://code.visualstudio.com/](https://code.visualstudio.com/)
    -   **macOS**: After installing VS Code, open it and press `Cmd+Shift+P` → "Shell Command: Install 'code' command in PATH"
    -   **Linux**: The `code` command is usually added to PATH automatically during installation
    -   **Windows**: Check "Add to PATH" during installation

-   **VS Code Settings** (REQUIRED): Disable auto-complete features for clean typing simulation
    -   Open VS Code
    -   Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
    -   Type: "Preferences: Open User Settings (JSON)"
    -   Add these settings:
    ```json
    {
      "editor.autoClosingBrackets": "never",
      "editor.autoClosingQuotes": "never",
      "editor.quickSuggestions": false
    }
    ```
    -   Save and restart VS Code

### Platform-Specific

#### macOS

-   **Python 3**: Built-in on modern macOS (10.15+), auto-installed via Homebrew if needed
-   **Accessibility Permissions**: You'll be prompted to grant terminal accessibility permissions on first run

#### Linux

-   **xdotool**: Automatically installed during setup
-   **X11 Display Server**: Required (standard on most Linux desktops)

#### Windows

-   **PowerShell**: Built-in (Windows 7+)
-   **Git Bash** or **WSL**: Recommended for running the script

## 🚀 Installation

### Quick Install (Recommended)

⚠️ **Before installing:** Make sure you've configured VS Code settings (see Prerequisites above)

Run this one-liner in your terminal to download and install `ghost-writer` with VS Code:

```bash
curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/vs-code/install.sh | bash
```

**What this does:**

-   Downloads the latest version of GhostWriter
-   Installs it to your PATH (`/usr/local/bin` or `~/.local/bin`)
-   Automatically installs all required dependencies:
    -   **Linux**: Installs `xdotool` via your package manager (apt, dnf, pacman, yum, zypper)
    -   **macOS**: Installs Python 3 via Homebrew if needed
    -   **Windows**: Validates PowerShell availability
-   Makes the script executable
-   Provides PATH setup instructions if needed

### Manual Installation

1. **Clone the repository (vs-code branch):**

    ```bash
    git clone -b vs-code https://github.com/juliusmarkwei/ghost-writer.git
    cd ghost-writer
    ```

2. **Run the install script:**

    ```bash
    bash install.sh
    ```

3. **Or run directly without installing:**
    ```bash
    chmod +x index.sh
    ./index.sh
    ```

### Verifying Installation

After installation, verify it works:

```bash
ghost-writer --help
```

If you see the help message, you're all set! 🎉

## 📖 Usage

### Basic Usage

Simply run `ghost-writer` in any project directory:

```bash
ghost-writer
```

This will:

1. Auto-detect source files using intelligent search:
   - **Nested patterns**: `src/app/main/`, `src/app/`, `src/main/`, etc.
   - **Common directories**: `src/`, `app/`, `lib/`, `packages/`, `server/`, `client/`, `api/`
   - **Entry points**: `index.ts`, `main.ts`, `app.ts`, `server.ts` (plus `.js` variants)
   - **Fallback**: If no entry point found, uses first directory with code files
2. If nothing found, use the built-in test source (comprehensive TypeScript example)
3. Run for 30 minutes with realistic typing speeds
4. Create a `simulation-subproject` folder for output files

### CLI Options

| Option                       | Alias | Default                 | Description                                      |
| :--------------------------- | :---- | :---------------------- | :----------------------------------------------- |
| `--duration <minutes>`       | `-d`  | `30`                    | How long to run the simulation (in minutes)      |
| `--min-delay <ms>`           |       | `150`                   | Minimum delay between keystrokes (faster typing) |
| `--max-delay <ms>`           |       | `500`                   | Maximum delay between keystrokes (slower typing) |
| `--name <name>`              |       | `simulation-subproject` | Name of the temporary subproject folder          |
| `--source <path>`            |       | (auto-detect)           | Path to source file or directory to type         |
| `--enable-browser-search`    |       | (enabled)               | Enable browser search feature (default)          |
| `--disable-browser-search`   |       |                         | Disable browser search feature                   |
| `--search-frequency <n>`     |       | `25`                    | Search trigger probability % (1-100)             |
| `--help`                     | `-h`  |                         | Display help message and exit                    |

### Examples

#### Run with default settings

```bash
ghost-writer
```

#### Run for 1 hour

```bash
ghost-writer --duration 60
```

#### Type faster (50-150ms delays)

```bash
ghost-writer --min-delay 50 --max-delay 150
```

#### Type slower (200-700ms delays)

```bash
ghost-writer --min-delay 200 --max-delay 700
```

#### Disable browser searches

```bash
ghost-writer --disable-browser-search
```

#### More frequent browser searches (50% trigger rate)

```bash
ghost-writer --search-frequency 50
```

#### Use a specific file

```bash
ghost-writer --source src/utils.ts
```

#### Process an entire directory

```bash
ghost-writer --source src/ --duration 90
```

#### Custom subproject name

```bash
ghost-writer --name my-demo-project
```

#### Combined options

```bash
ghost-writer --source src/components/ --duration 120 --min-delay 80 --max-delay 200 --name demo
```

## 🎯 How It Works

1. **Project Detection**: Automatically finds your project root by looking for `package.json`
2. **Smart Source Resolution**:
    - If `--source` specified: Uses that exact file or directory
    - If no `--source`: Intelligently searches for source files:
      - Checks nested patterns: `src/app/main/`, `src/app/`, `app/main/`, etc.
      - Looks in common directories: `src/`, `app/`, `lib/`, `packages/`, `server/`, `client/`, `api/`
      - Searches for entry points: `index.ts`, `main.ts`, `app.ts`, `server.ts` (+ `.js` variants)
      - Falls back to first directory with `.ts`, `.js`, `.tsx`, or `.jsx` files
    - If nothing found: Uses built-in comprehensive test source
3. **File Processing**:
    - **Single file**: Types just that file
    - **Directory**: Processes all files recursively (excluding hidden files and `node_modules`)
4. **Human-Like Typing Simulation**:
    - Opens each file in VS Code (reuses existing window with `code -r`)
    - **Context-aware typing**: Faster on whitespace, slower on special characters (150-500ms base delays)
    - **Smart pauses**: Automatically pauses before functions, classes, and other major constructs
    - **Typo simulation**: Occasional backspace/correction (~5% of characters)
    - **Browser searches**: Periodically opens browser to search for relevant programming topics with full interaction (~25% of pauses) - scrolls, clicks links, reads content, then minimizes
    - **Auto-complete handling**: Seamlessly removes VS Code's auto-completed brackets/quotes
    - **Safety monitoring**: Continuously monitors mouse position and stops if movement detected
5. **Looping**: After completing all files, waits briefly and restarts until duration expires

## 🛡️ Safety Features

### Mouse Movement Detection

**Instant termination** when you move your mouse:

-   Continuously monitors cursor position
-   Detects any movement from the initial position
-   Terminates the simulation immediately
-   Gives you instant control back

### Focus Management

**Prevents typing in wrong applications**:

-   Only types into VS Code and other safe applications
-   Automatically refocuses your editor if focus is lost
-   Pauses if an unsafe application is active
-   Whitelist includes: VS Code, Cursor, Windsurf, Terminal, iTerm, Warp, and other code editors

### Graceful Cleanup

-   Handles `Ctrl+C` (SIGINT) cleanly
-   Stops mouse monitor process
-   Cleans up temporary files
-   No zombie processes left behind

## 🔧 Troubleshooting

### macOS: `osascript is not allowed to send keystrokes`

**Solution:**

1. Go to **System Settings** (or System Preferences on older macOS)
2. Navigate to **Privacy & Security** → **Accessibility**
3. Find your **Terminal** application (Terminal.app, iTerm, etc.)
4. **Check the box** to allow it to control your computer
5. Restart your terminal and try again

### Linux: `xdotool: command not found`

**Solution:**
The install script should handle this automatically, but if needed:

```bash
# Debian/Ubuntu
sudo apt-get update && sudo apt-get install -y xdotool

# Fedora
sudo dnf install -y xdotool

# Arch Linux
sudo pacman -S xdotool

# openSUSE
sudo zypper install xdotool
```

### VS Code: `code: command not found`

**Solution:**

The `code` command must be in your PATH. Here's how to add it:

**macOS:**

1. Open VS Code
2. Press `Cmd+Shift+P` to open Command Palette
3. Type: "Shell Command: Install 'code' command in PATH"
4. Select it and restart your terminal

**Linux:**

```bash
# Usually added automatically during VS Code installation
# If not, reinstall VS Code or add it to PATH manually
export PATH="$PATH:/usr/share/code/bin"
```

**Windows:**

-   During VS Code installation, check "Add to PATH"
-   Or add VS Code's bin folder to your system PATH manually

### Windows: Script won't run

**Solutions:**

1. **Use Git Bash** or **WSL** (Windows Subsystem for Linux)
2. Ensure PowerShell is available:
    ```bash
    powershell.exe -Command "Write-Host 'PowerShell works'"
    ```
3. Run from Git Bash, not Command Prompt

### Mouse detection not working

**Possible causes:**

-   **macOS**: Python 3 not installed (install via Homebrew: `brew install python3`)
-   **Linux**: xdotool not installed or not in PATH
-   **Windows**: PowerShell scripting disabled (run: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`)

### Typing is too slow/fast

**Solution:**
Adjust the delay parameters:

```bash
# Faster typing (50-100ms delays)
ghost-writer --min-delay 50 --max-delay 100

# Slower typing (300-600ms delays)
ghost-writer --min-delay 300 --max-delay 600
```

### Script stops immediately

**Possible causes:**

1. **Mouse moved**: Even slight touchpad touches trigger termination (this is intentional!)
2. **Source file not found**: Check the error message and verify the path
3. **VS Code not installed**: The script requires VS Code with the `code` command in PATH
4. **VS Code not focused**: Make sure VS Code window is active when the script starts

### Permission errors during installation

**Solution:**

If `/usr/local/bin` is not writable:

```bash
# Install to user directory instead
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/main/index.sh -o ~/.local/bin/ghost-writer
chmod +x ~/.local/bin/ghost-writer

# Add to PATH (add this to ~/.bashrc or ~/.zshrc)
export PATH="$PATH:$HOME/.local/bin"
```

## 🗂️ Project Structure

```
ghost-writer/
├── index.sh       # Main executable script
├── install.sh     # Installation script with dependency management
├── README.md      # This file
└── LICENSE        # License information
```

## 🔄 Uninstallation

To remove `ghost-writer` from your system:

```bash
# macOS/Linux (if installed to /usr/local/bin)
rm -r /usr/local/bin/ghost-writer

# macOS/Linux (if installed to ~/.local/bin)
rm -r ~/.local/bin/ghost-writer

# Windows (Git Bash)
rm -r ~/bin/ghost-writer
```

**Optional**: Remove generated test source if it was created:

```bash
rm default_simulation_source.ts  # In your project root if generated
```

## 📝 Use Cases

-   **Live Coding Demos**: Present code being written in real-time
-   **Tutorial Videos**: Show code appearing naturally without video editing
-   **Pair Programming Simulations**: Demonstrate collaborative coding workflows
-   **Teaching**: Help students follow along at a comfortable pace
-   **Screencasts**: Create engaging content with realistic typing
-   **Testing**: Verify your typing-based features or scripts
-   **Fun**: Just watch code write itself! 🎭

## 🤝 Contributing

Contributions are welcome! Feel free to:

-   Report bugs
-   Suggest features
-   Submit pull requests
-   Improve documentation

## 📄 License

[Add your license here - e.g., MIT License]

## 🙏 Acknowledgments

-   Built with cross-platform compatibility in mind
-   Inspired by the need for realistic code demonstration tools
-   Thanks to the open-source community for tools like xdotool and osascript

## 📞 Support

If you encounter issues:

1. Check the [Troubleshooting](#-troubleshooting) section
2. Review existing [GitHub Issues](https://github.com/juliusmarkwei/ghost-writer/issues)
3. Open a new issue with:
    - Your OS and version
    - The command you ran
    - The complete error message
    - Steps to reproduce

---

**Made with ❤️ for developers who love automation**

_Happy Ghost Writing! 👻⌨️_
