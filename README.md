# GhostWriter

A cross-platform CLI tool that simulates a developer typing code. It reads a source file from your project and "types" it into a simulated subproject, mimicking human typing speeds and habits.

## Features

-   **Human-like Typing**: Variable typing speeds to mimic real behavior.

*   **Realistic Pauses**: Occasional long pauses (30-60s) to simulate "thinking" or allow user control.
*   **Automated Workflow**: Automatically creates a temporary subproject, opens your editor, and starts typing.
*   **Looping Mode**: Runs continuously (default 30 minutes), recreating the session after each cycle.

-   **Language Agnostic**: Dynamically detects source file extension (e.g., `.py`, `.go`) and creates a matching simulation file.
-   **Safe Editor Enforcement**: Only types when a safe editor (VSCode, JetBrains, Terminal, etc.) is focused. Pauses automatically if you switch to a browser or other app.
-   **Auto-Termination**: Instantly stops the simulation if you move the mouse.
-   **Robust Cleanup**: Ensures a unique, fresh file is created for every loop cycle to prevent appending or caching issues.
-   **Cross-Platform**:
    -   **macOS**: Uses `osascript` (no dependencies).
    -   **Linux**: Uses `xdotool` (requires installation).
    -   **Windows**: Uses PowerShell (native).
-   **Stand-alone**: A single shell script with no heavy Node.js dependencies.

## Prerequisites

-   **Linux**: Install `xdotool` (`sudo apt install xdotool`).
-   **macOS/Linux**: Grant accessibility/automation permissions to your terminal.

## Installation

**Quick Install (macOS, Linux, Windows Git Bash):**

Run this command in your terminal to download and install `ghost-writer`:

```bash
curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/main/install.sh | bash
```

This will install `ghost-writer` to your path. You can then run it simply by typing `ghost-writer` (or `index.sh` if running locally).

## Usage

Make the script executable:

```bash
chmod +x index.sh
```

Run the tool:

```bash
./index.sh [options]
```

### CLI Options

| Option                 | Alias | Default                 | Description                                                    |
| :--------------------- | :---- | :---------------------- | :------------------------------------------------------------- |
| `--duration <minutes>` | `-d`  | `30`                    | Duration of the simulation loop in minutes.                    |
| `--min-delay <ms>`     |       | `100`                   | Minimum delay between keystrokes (faster typing).              |
| `--max-delay <ms>`     |       | `300`                   | Maximum delay between keystrokes (slower typing).              |
| `--name <name>`        |       | `simulation-subproject` | Name of the subproject folder to create.                       |
| `--source <path>`      |       | `src/app/main/index.ts` | Relative path to the source file (fallback to `src/index.ts`). |
| `--help`               | `-h`  |                         | Display help message.                                          |

### Examples

**Run for 1 hour with fast typing:**

```bash
./index.sh --duration 60 --min-delay 20 --max-delay 80
```

**Use a custom source file:**

```bash
./index.sh --source src/utils.ts
```

## Troubleshooting

### `osascript is not allowed to send keystrokes` (macOS)

Go to **System Settings > Privacy & Security > Accessibility** and ensure your Terminal application is checked.

### `xdotool: command not found` (Linux)

Install it using your package manager (e.g., `sudo apt install xdotool`).

## Project Structure

-   `index.sh`: The main, standalone executable script.
