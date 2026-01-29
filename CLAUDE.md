# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

GhostWriter is a cross-platform CLI tool that simulates a developer typing code in real-time within Vim with sophisticated human-like behavior. It reads source files and "types" them character-by-character with context-aware delays (150-500ms base range), intelligent pauses at natural breakpoints, occasional typo simulation, browser search integration for realistic research behavior, and safety features like mouse movement detection and focus management.

The tool is designed for live coding demos, tutorial videos, and educational content where code needs to appear as if being typed naturally by a real developer.

## Core Architecture

### Main Script: `index.sh`

This is the single executable bash script that contains the entire application logic. It's structured as follows:

1. **Configuration & Defaults** (lines 1-122): Defines runtime parameters and embeds a comprehensive TypeScript test source that's used when no source file is found
2. **CLI Parsing** (lines 125-158): Handles command-line arguments using bash case statements
3. **Project Detection** (lines 163-177): Walks up directory tree to find `package.json` for project root
4. **OS Detection & Dependencies** (lines 179-245): Identifies OS (macOS/Linux/Windows) and validates required tools (xdotool, osascript, PowerShell, VS Code)
5. **Source Path Resolution** (lines 253-360): Intelligent source handling with dynamic auto-detection:
   - User-specified paths (absolute or relative)
   - Multi-level search strategy:
     - Nested patterns (src/app/main/, src/app/, etc.)
     - Common directories (src/, app/, lib/, packages/, server/, client/, api/)
     - Entry point files (index.ts, main.ts, app.ts, server.ts, plus .js variants)
     - Directory fallback (first directory with .ts/.js/.tsx/.jsx files)
   - Embedded test content as final fallback
6. **Platform-Specific Typing Functions** (lines 304-377): Character-by-character typing simulation using OS-native tools:
   - **macOS**: `osascript` with AppleScript to send keystrokes
   - **Linux**: `xdotool` for X11 keyboard simulation
   - **Windows**: PowerShell's `System.Windows.Forms.SendKeys`
7. **VS Code Integration** (lines 377-395): `handle_vscode_char()` function manages auto-complete by detecting opening brackets/quotes and deleting auto-completed closing characters
8. **Browser Search Integration** (lines 402-490): Realistic developer research behavior:
   - `open_browser_search()`: Platform-specific browser opening (open/xdg-open/PowerShell)
   - `generate_contextual_search()`: Creates relevant search queries based on code context
   - `should_trigger_browser_search()`: Probabilistic triggering with cooldown mechanism
9. **Human-Like Typing System** (lines 490-680): Sophisticated typing behavior including:
   - `calculate_typing_delay()`: Context-aware speed (fast on whitespace, slow on special chars)
   - `should_pause_before_line()`: Detects natural pause points (functions, classes, etc.)
   - `execute_pause()`: Executes pauses with appropriate durations
   - `simulate_typo()`: Occasional typos with backspace and correction
10. **Safety Systems** (lines 680-820): Mouse movement detection and focus management to prevent typing in wrong applications
11. **File Processing & Vim Integration** (lines 850-1000): Opens files in Vim, enters Insert mode, types content line-by-line with human-like behavior and browser searches, saves periodically
12. **Main Loop** (lines 1000-1120): Cycles through files repeatedly until duration expires, with cleanup between cycles

### Key Design Patterns

**State Management**: Uses global variables and function-scoped state for cycle tracking, mouse monitoring, and focus detection.

**Platform Abstraction**: All platform-specific operations are wrapped in conditional blocks that check `$OS_NAME`, allowing a single codebase to work across macOS, Linux, and Windows.

**Special Character Handling**: The `type_char` function (lines 377-410) has platform-specific escaping logic, particularly for macOS where characters like `"`, `\`, and `$` require special AppleScript syntax.

**Safety-First Design**: The tool continuously monitors mouse position and active window focus, immediately terminating if the user moves their mouse or if typing would occur in an unsafe application.

**VS Code Workflow**: The tool integrates with VS Code by:
1. Opening files with `code -r` to reuse existing window
2. Activating and maximizing the VS Code window
3. Typing content with human-like behavior (context-aware delays, smart pauses, typos)
4. Handling VS Code's auto-complete by deleting auto-completed closing characters
5. Periodically saving with Cmd/Ctrl+S (no mode switching needed)

## Installation Script: `install.sh`

Standalone installer that downloads the latest `index.sh` from GitHub and installs it to the user's PATH. It also handles platform-specific dependency installation:
- **macOS**: Installs Python3 via Homebrew if needed (for mouse position detection)
- **Linux**: Installs xdotool via system package manager
- **Windows**: Validates PowerShell availability

## Key Technical Challenges Addressed

### 1. Cross-Platform Keyboard Simulation
Each OS has different mechanisms for programmatic keyboard input. The script uses:
- **macOS**: AppleScript via `osascript` (built-in, no installation required)
- **Linux**: xdotool (requires X11 display server)
- **Windows**: PowerShell SendKeys API

### 2. Mouse Position Detection
Uses platform-native APIs wrapped in helper functions:
- **macOS**: Python ctypes calling CoreGraphics framework directly
- **Linux**: xdotool getmouselocation
- **Windows**: PowerShell System.Windows.Forms.Cursor API

### 3. VS Code Integration & Human-Like Typing
The tool targets VS Code with sophisticated human-like behavior:
- **Auto-Complete Handling**: Detects VS Code's auto-completed brackets/quotes and removes them to prevent duplication
- **Context-Aware Speed**: Types faster on whitespace (2x), slower on special characters (+30-50ms)
- **Smart Pauses**: Automatically pauses before major constructs (functions, classes, imports) with appropriate durations
- **Typo Simulation**: Randomly introduces typos (~5% chance) with realistic backspace and correction
- **Window Management**: Uses `code -r` for window reuse and platform-specific activation/maximization

### 4. Special Character Escaping
AppleScript on macOS requires careful escaping of quotes, backslashes, and dollar signs. The `type_char` function handles these as special cases using specific AppleScript syntax patterns.

### 5. VS Code Window Maximization
The script maximizes the VS Code window to provide a better demo experience:
- **macOS**: Uses AppleScript to activate "Visual Studio Code" and set window position/size
- **Linux**: Uses `wmctrl` or `xdotool` to activate and maximize window
- **Windows**: Uses PowerShell to send Win+Up key to maximize window

## Development Workflow

### Testing Changes

Since this is a bash script, there's no build step. Test directly:

```bash
./index.sh --duration 1 --source README.md
```

### Testing with Custom Source

```bash
./index.sh --source src/ --duration 2 --min-delay 50 --max-delay 150
```

### Testing Installation

```bash
bash install.sh
ghost-writer --help
```

### Debugging

Enable bash tracing for detailed execution logs:

```bash
bash -x index.sh --duration 1
```

## Common Modification Scenarios

### Adding a New CLI Option

1. Add default value at top of script (lines 3-9)
2. Add case statement in argument parsing loop (lines 147-157)
3. Update `show_help()` function (lines 125-143)

### Supporting a New Editor

To add support for editors beyond VS Code:

1. Update file opening logic in `simulate_typing_session()` to launch the new editor
2. Update `is_safe_app()` whitelist to include the editor's process name
3. Adjust `handle_vscode_char()` or create new function to handle editor-specific auto-complete behavior

### Adjusting Typing Behavior

- **Base Speed**: Modify `MIN_DELAY_MS` and `MAX_DELAY_MS` defaults (lines 5-6, currently 150-500ms)
- **Context Multipliers**: Adjust whitespace (2x faster) and special char slowdown (+30-50ms) in `calculate_typing_delay()`
- **Smart Pauses**: Modify pause durations in `execute_pause()` (long: 1.5-4s, medium: 0.8-2s, short: 0.3-0.8s, micro: 0.1-0.3s)
- **Typo Frequency**: Change the 5% chance in `simulate_typo()` (currently `RANDOM % 20 != 0`)
- **Save Frequency**: Change the 20-second interval check in main typing loop
- **Browser Search Frequency**: Adjust `BROWSER_SEARCH_FREQUENCY` (default 25%) or `SEARCH_COOLDOWN` (default 60s) in lines 10-14

### Platform-Specific Fixes

All platform-specific logic checks `$OS_NAME`:
- `"Darwin"` = macOS
- `"Linux"` = Linux
- Anything else = Windows (via Git Bash/WSL)

Example: To fix a macOS keystroke issue, modify the `"Darwin"` branch in `type_char()` function.

## Important Constraints

1. **Single File Architecture**: The entire application is in `index.sh` to simplify distribution (users get one file)
2. **No External Dependencies** (except platform tools): The script only relies on OS-native tools and doesn't require npm, pip, or other package managers (beyond VS Code itself)
3. **VS Code-Specific**: The typing simulation is optimized for VS Code's behavior (auto-complete handling, Cmd/Ctrl+S saves, window management)
4. **Line-by-Line Processing**: Files are typed line-by-line with intelligent pauses at natural breakpoints (functions, classes, etc.)
5. **GUI-Based Typing**: Types into VS Code GUI application with proper window management and focus detection

## Project Structure

```
.
├── index.sh           # Main executable (the entire application)
├── install.sh         # Installation script for GitHub distribution
├── README.md          # User-facing documentation
├── DISTRIBUTION.md    # Guide for distributing the tool
└── CLAUDE.md          # This file
```

## Safety and Termination

The tool implements multiple safety mechanisms:

1. **Mouse Movement Detection**: Background process monitors cursor position, terminates immediately on movement
2. **Focus Management**: Only types into whitelisted "safe" applications (VS Code, Cursor, Windsurf, Terminal, iTerm, etc.)
3. **Graceful Cleanup**: Handles SIGINT (Ctrl+C) and SIGTERM, kills monitor processes, cleans temp files
4. **Time Limits**: Respects user-specified duration and stops cleanly when time expires

## Key Variables

- `DURATION_MINUTES`: How long to run the simulation
- `MIN_DELAY_MS` / `MAX_DELAY_MS`: Base typing speed range (default 150-500ms, modified by context-aware system)
- `ENABLE_BROWSER_SEARCH`: Enable/disable browser search feature (default: true)
- `BROWSER_SEARCH_FREQUENCY`: Probability percentage for triggering searches (default: 25)
- `LAST_SEARCH_TIME`: Unix timestamp of last browser search (for cooldown tracking)
- `SEARCH_COOLDOWN`: Minimum seconds between searches (default: 60)
- `SOURCE_PATH`: Absolute path to source file or directory
- `SUBPROJECT_PATH`: Where temporary simulation files are created
- `MOUSE_MONITOR_PID`: PID of background mouse monitoring process
- `KNOWN_EDITOR_APP`: Name of the safe editor application currently in focus (typically Terminal/Vim)
- `FIRST_CYCLE`: Boolean flag to track if this is the first run (affects wait times)
- `last_save_time`: Timestamp of last file save in Vim (for periodic auto-save with :w)
