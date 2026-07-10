# GhostWriter

A cross-platform CLI tool that simulates a developer at work in real-time. It reads source files from your project and "types" them into Vim (terminal-based editor), hopping between files a line or two at a time, taking breaks to search the web, and glancing at Slack—mimicking human typing speeds and natural coding habits. Perfect for demonstrations, tutorials, or just having fun watching code write itself.

## ✨ Features

-   **Human-like Typing**: Variable typing speeds (150-380ms delays) to mimic realistic behavior
-   **File Hopping**: Opens all files together as vim buffers and types a burst of 1-2 lines in one file, pauses, switches to another, and continues there—just like a real developer moving around a codebase
-   **Realistic Pauses**: Occasional "thinking" pauses and longer "working through a tricky bit" breaks to simulate developer workflow
-   **Browser Research**: Steps away to search the web for topics derived from your code (language, class/function names) in the Dia browser (configurable via `--browser-app`, falls back to your default browser)
-   **Slack Presence**: Opens Slack, lingers, and drafts a message to a random member—**never sends anything** (the message is always cleared, Enter is never pressed)
-   **Smart Focus Management**: Automatically detects and maintains focus on safe editor applications
-   **Mouse Movement Detection**: Instantly stops when you move your mouse, giving you immediate control
-   **Accurate Duration**: Every pause and break is clamped to the remaining time, so the session never overruns `--duration`
-   **Directory & File Support**: Process entire directories or individual files
-   **Automated Workflow**: Creates temporary subprojects, opens files in Vim, and starts typing automatically
-   **Looping Mode**: Runs continuously for a specified duration (default 30 minutes), recreating sessions after each cycle
-   **Language Agnostic**: Dynamically detects file extensions and creates matching simulation files
-   **Built-in Test Source**: Includes comprehensive TypeScript test content when no source is specified
-   **Robust Cleanup**: Ensures fresh files for every cycle with proper signal handling
-   **Cross-Platform Support**:
    -   **macOS**: Uses `osascript` (built-in); browser + Slack breaks fully supported
    -   **Linux**: Uses `xdotool` (auto-installed); browser breaks supported
    -   **Windows**: Uses PowerShell (built-in); browser breaks supported

## 📋 Prerequisites

### All Platforms

-   **Vim**: Must be installed (usually pre-installed on macOS and Linux)
    -   macOS: `brew install vim` (if not present)
    -   Linux: `sudo apt-get install vim` (or equivalent)
    -   Windows: Available via Git Bash or WSL

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

Run this one-liner in your terminal to download and install `ghost-writer`:

```bash
curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/main/install.sh | bash
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

1. **Clone the repository:**

    ```bash
    git clone https://github.com/juliusmarkwei/ghost-writer.git
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

1. Search for default source files (`src/app/main/index.ts`, `src/index.ts`, or `index.ts`)
2. If none found, use the built-in test source (comprehensive TypeScript example)
3. Run for 30 minutes with realistic typing speeds
4. Create a `simulation-subproject` folder for output files

### CLI Options

| Option                  | Alias | Default                 | Description                                       |
| :---------------------- | :---- | :---------------------- | :------------------------------------------------ |
| `--duration <minutes>`  | `-d`  | `30`                    | How long to run the simulation (in minutes)       |
| `--min-delay <ms>`      |       | `150`                   | Minimum delay between keystrokes (faster typing)  |
| `--max-delay <ms>`      |       | `380`                   | Maximum delay between keystrokes (slower typing)  |
| `--name <name>`         |       | `simulation-subproject` | Name of the temporary subproject folder           |
| `--source <path>`       |       | (auto-detect)           | Path to source file or directory to type          |
| `--terminal-app <name>` |       | `Warp Preview`          | Terminal app that hosts the vim window (macOS)     |
| `--slack-app <name>`    |       | `Slack`                 | Slack desktop app name (macOS)                    |
| `--no-browser`          |       |                         | Disable the browser "research" breaks             |
| `--no-slack`            |       |                         | Disable the Slack breaks                          |
| `--break-chance <0-100>`|       | `45`                    | Chance of stepping away between file hops         |
| `--help`                | `-h`  |                         | Display help message and exit                     |

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

#### Type slower (200-500ms delays)

```bash
ghost-writer --min-delay 200 --max-delay 500
```

#### Pure typing, no distractions

```bash
ghost-writer --no-browser --no-slack
```

#### Fewer breaks, host vim in a specific terminal

```bash
ghost-writer --break-chance 15 --terminal-app "iTerm"
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
2. **Source Resolution**:
    - If `--source` specified: Uses that exact file or directory
    - If no `--source`: Searches for default files in order: `src/app/main/index.ts` → `src/index.ts` → `index.ts`
    - If none found: Uses built-in comprehensive test source
3. **File Processing**:
    - **Single file**: Types just that file
    - **Directory**: Processes all files recursively (excluding hidden files and `node_modules`)
4. **Typing Simulation**:
    - Opens **all files together** as numbered buffers in a single Vim window (in a new terminal window)
    - Hops between files, typing a burst of 1-2 lines in one, then switching to another (`:bN`) and continuing where it left off
    - Preserves original indentation
    - Random delays between keystrokes, plus occasional "thinking" pauses
5. **Stepping Away**: Every few file hops it may take a break—searching the web in the Dia browser for topics derived from your code, glancing at Slack (drafting but never sending a message), or just resting. Each break is time-boxed so the session never overruns `--duration`.
6. **Looping**: After completing all files, waits briefly and restarts until duration expires

## 🛡️ Safety Features

### Mouse Movement Detection

**Instant termination** when you move your mouse:

-   Continuously monitors cursor position
-   Detects any movement from the initial position
-   Terminates the simulation immediately
-   Gives you instant control back

### Focus Management

**Prevents typing in wrong applications**:

-   Only types into safe applications (Terminal, Vim, iTerm, etc.)
-   Automatically refocuses your editor if focus is lost
-   Pauses if an unsafe application is active
-   Whitelist includes: Terminal, iTerm, Warp, Alacritty, Hyper, kitty, vim, nvim, and other terminal emulators

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

### Vim: `vim: command not found`

**Solution:**

**macOS:**

```bash
brew install vim
```

**Linux:**

```bash
sudo apt-get install vim  # Debian/Ubuntu
sudo dnf install vim      # Fedora
sudo pacman -S vim        # Arch
```

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
3. **Vim not installed**: The script needs Vim to be installed

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
