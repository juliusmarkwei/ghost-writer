# How to Distribute GhostWriter

We use GitHub as the sole source of truth for distribution. Users can install the tool directly from your repository.

## The "One-Line" Install (Recommended)

Users can install the tool on macOS, Linux, and Windows (Git Bash) by running a single command that pulls directly from GitHub.

### 1. Setup

1.  Push your code to your GitHub repository (e.g., `juliusmarkwei/ghost-writer`).
2.  Edit `install.sh` and ensure `REPO_USER` and `REPO_NAME` match your repository.

### 2. User Instructions

Add this to your README:

> **Install GhostWriter:**
>
> ```bash
> curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/main/install.sh | bash
> ```

### How it works

This script:

1.  Fetches `index.sh` directly from your GitHub `main` branch.
2.  Installs it to `/usr/local/bin` (Mac/Linux) or `~/bin` (Windows).
3.  Automatically installs dependencies (like `xdotool`) if needed.
4.  Ensures the directory is in your PATH.

## Manual Install

Users can also simply clone the repo:

```bash
git clone https://github.com/juliusmarkwei/ghost-writer.git
cd ghost-writer
./index.sh
```
