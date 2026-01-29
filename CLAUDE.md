# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

GhostWriter is a cross-platform CLI tool that simulates a developer typing code in real-time within Vim with sophisticated human-like behavior. It reads source files and "types" them character-by-character with context-aware delays (150-500ms base range), intelligent pauses at natural breakpoints, occasional typo simulation, and safety features like mouse movement detection and focus management.

The tool is designed for live coding demos, tutorial videos, and educational content where code needs to appear as if being typed naturally by a real developer.

## Core Architecture

### Main Script: `index.sh`

This is the single executable bash script that contains the entire application logic. It's structured as follows:

1. **Configuration & Defaults** (lines 1-122): Defines runtime parameters and embeds a comprehensive TypeScript test source that's used when no source file is found
2. **CLI Parsing** (lines 125-158): Handles command-line arguments using bash case statements
3. **Project Detection** (lines 163-177): Walks up directory tree to find `package.json` for project root
4. **OS Detection & Dependencies** (lines 179-245): Identifies OS (macOS/Linux/Windows) and validates required tools (xdotool, osascript, PowerShell, Vim)
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
7. **Human-Like Typing System**: Sophisticated typing behavior including:
   - `calculate_typing_delay()`: Context-aware speed (fast on whitespace, slow on special chars)
   - `should_pause_before_line()`: Detects natural pause points (functions, classes, etc.)
   - `execute_pause()`: Executes pauses with appropriate durations
   - `simulate_typo()`: Occasional typos with backspace and correction
8. **Safety Systems**: Mouse movement detection and focus management to prevent typing in wrong applications
9. **File Processing & Vim Integration**: Opens files in Vim, enters Insert mode once, types entire file, saves only at the end
10. **Main Loop**: Cycles through files repeatedly until duration expires, with cleanup between cycles

### Key Design Patterns

**State Management**: Uses global variables and function-scoped state for cycle tracking, mouse monitoring, and focus detection.

**Platform Abstraction**: All platform-specific operations are wrapped in conditional blocks that check `$OS_NAME`, allowing a single codebase to work across macOS, Linux, and Windows.

**Special Character Handling**: The `type_char` function (lines 377-410) has platform-specific escaping logic, particularly for macOS where characters like `"`, `\`, and `$` require special AppleScript syntax.

**Safety-First Design**: The tool continuously monitors mouse position and active window focus, immediately terminating if the user moves their mouse or if typing would occur in an unsafe application.

**Vim Workflow**: The tool integrates with Vim by:
1. Opening files in a new Terminal window with Vim
2. Entering Insert mode once at the start
3. Typing entire file with human-like behavior (context-aware delays, smart pauses, typos)
4. Never exiting Insert mode during typing (no periodic saves)
5. Only saving once at the very end with :w

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

### 3. Vim Integration & Human-Like Typing
The tool targets Vim with sophisticated human-like behavior:
- **Modal Editing**: Enters Insert mode once at start, stays in Insert mode for entire file
- **Context-Aware Speed**: Types faster on whitespace (2x), slower on special characters (+30-50ms)
- **Smart Pauses**: Automatically pauses before major constructs (functions, classes, imports) with appropriate durations
- **Typo Simulation**: Randomly introduces typos (~5% chance) with realistic backspace and correction
- **No Periodic Saves**: Types entire file without interruption, saves only at the end

### 4. Special Character Escaping
AppleScript on macOS requires careful escaping of quotes, backslashes, and dollar signs. The `type_char` function handles these as special cases using specific AppleScript syntax patterns.

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

### Git Commit Guidelines

When creating commits for this project:

**IMPORTANT:** Do NOT include "Co-Authored-By: Claude" or any AI assistant attribution in commit messages.

- Write clear, descriptive commit messages
- Use conventional commit format: `feat:`, `fix:`, `docs:`, `refactor:`, etc.
- Include details about what changed and why
- Keep commits focused on a single logical change
- **Never** add co-author attribution for AI assistants

## Common Modification Scenarios

### Adding a New CLI Option

1. Add default value at top of script (lines 3-9)
2. Add case statement in argument parsing loop (lines 147-157)
3. Update `show_help()` function (lines 125-143)

### Adjusting Typing Behavior

- **Base Speed**: Modify `MIN_DELAY_MS` and `MAX_DELAY_MS` defaults (lines 5-6, currently 150-500ms)
- **Context Multipliers**: Adjust whitespace (2x faster) and special char slowdown (+30-50ms) in `calculate_typing_delay()`
- **Smart Pauses**: Modify pause durations in `execute_pause()` (long: 1.5-4s, medium: 0.8-2s, short: 0.3-0.8s, micro: 0.1-0.3s)
- **Typo Frequency**: Change the 5% chance in `simulate_typo()` (currently `RANDOM % 20 != 0`)

### Platform-Specific Fixes

All platform-specific logic checks `$OS_NAME`:
- `"Darwin"` = macOS
- `"Linux"` = Linux
- Anything else = Windows (via Git Bash/WSL)

Example: To fix a macOS keystroke issue, modify the `"Darwin"` branch in `type_char()` function.

## Important Constraints

1. **Single File Architecture**: The entire application is in `index.sh` to simplify distribution (users get one file)
2. **No External Dependencies** (except platform tools): The script only relies on OS-native tools and doesn't require npm, pip, or other package managers (beyond Vim itself)
3. **Vim-Specific**: The typing simulation is optimized for Vim's modal editing (stays in Insert mode throughout)
4. **Line-by-Line Processing**: Files are typed line-by-line with intelligent pauses at natural breakpoints (functions, classes, etc.)
5. **Terminal-Based Typing**: Types into Vim in Terminal with proper window management and focus detection

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
- `SOURCE_PATH`: Absolute path to source file or directory
- `SUBPROJECT_PATH`: Where temporary simulation files are created
- `MOUSE_MONITOR_PID`: PID of background mouse monitoring process
- `KNOWN_EDITOR_APP`: Name of the safe editor application currently in focus (typically Terminal)
- `FIRST_CYCLE`: Boolean flag to track if this is the first run (affects wait times)
