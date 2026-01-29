# GhostWriter - Branch-Based Installation

GhostWriter supports multiple editors through different branches. Choose the one that fits your workflow!

## 📊 Available Branches

### 🎯 `main` - Vim (Default, Recommended)

**Best for:** Most users, stable and reliable

**Editor:** Vim
**Status:** ✅ Stable
**Pros:**
- Most stable and tested
- Terminal-based, works everywhere
- Usually pre-installed on Unix systems
- No complex configuration needed

**Cons:**
- Modal editing (Insert mode vs Normal mode)
- Requires basic Vim knowledge

**Installation:**
```bash
curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/main/install.sh | bash
```

---

### 🎨 `nano` - Nano Editor

**Best for:** Users who prefer simpler editors without modes

**Editor:** Nano
**Status:** ✅ Stable
**Pros:**
- Simpler than Vim (no modes)
- Terminal-based
- Straightforward keyboard shortcuts
- No auto-complete interference

**Cons:**
- Less powerful than Vim
- May need installation on some systems

**Installation:**
```bash
curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/nano/install.sh | bash
```

---

### 💻 `vs-code` - Visual Studio Code

**Best for:** Advanced users willing to configure VS Code settings

**Editor:** VS Code
**Status:** ⚠️ Experimental
**Pros:**
- GUI-based (if you prefer graphical editors)
- Modern editor with rich features
- Good for demonstrations

**Cons:**
- **Requires manual VS Code configuration** (must disable auto-complete)
- Auto-complete causes issues if not configured properly
- More complex setup
- Not as stable as terminal-based options

**Requirements:**
1. VS Code must be installed
2. `code` command must be in PATH
3. **MUST configure VS Code settings** (see below)

**VS Code Settings (REQUIRED):**
```json
{
  "editor.autoClosingBrackets": "never",
  "editor.autoClosingQuotes": "never",
  "editor.quickSuggestions": false
}
```

**Installation:**
```bash
curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/vs-code/install.sh | bash
```

---

## 🔄 Switching Between Branches

If you've already installed GhostWriter and want to switch to a different editor:

```bash
# Remove current installation
rm $(which ghost-writer)

# Install from desired branch
curl -fsSL https://raw.githubusercontent.com/juliusmarkwei/ghost-writer/BRANCH/install.sh | bash
```

Replace `BRANCH` with: `main`, `nano`, or `vs-code`

---

## 🎯 Which Branch Should I Choose?

### Choose **`main` (Vim)** if:
- ✅ You want the most stable version
- ✅ You're comfortable with Vim
- ✅ You want something that "just works"
- ✅ You prefer terminal-based editors

### Choose **`nano`** if:
- ✅ You prefer simpler editors
- ✅ You don't want to deal with Vim modes
- ✅ You want terminal-based but easier than Vim
- ✅ You want zero configuration

### Choose **`vs-code`** if:
- ✅ You specifically need VS Code for your demo
- ✅ You're comfortable configuring VS Code settings
- ⚠️ You're willing to troubleshoot potential issues
- ⚠️ You understand this is experimental

---

## 📝 Feature Comparison

| Feature | main (Vim) | nano | vs-code |
|---------|-----------|------|---------|
| **Stability** | ✅ Excellent | ✅ Excellent | ⚠️ Good |
| **Setup Complexity** | 🟢 Easy | 🟢 Very Easy | 🔴 Complex |
| **Configuration Required** | None | None | **Required** |
| **Terminal-Based** | ✅ Yes | ✅ Yes | ❌ No (GUI) |
| **Auto-Complete Issues** | ✅ None | ✅ None | ⚠️ Possible |
| **Pre-installed?** | Usually | Usually | ❌ No |
| **Human-Like Typing** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Dynamic Source Detection** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Smart Pauses** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Typo Simulation** | ✅ Yes | ✅ Yes | ✅ Yes |

---

## 🚀 All Branches Include

All branches have these core features:
- ✅ **Human-like typing** with context-aware delays
- ✅ **Smart pause system** (4 types of pauses)
- ✅ **Typo simulation** (~5% frequency)
- ✅ **Dynamic source detection** (100+ project structures)
- ✅ **Mouse movement detection** (instant stop)
- ✅ **Cross-platform support** (macOS, Linux, Windows)

The only difference is the **editor** they use!

---

## 📖 Documentation

Each branch has its own README with editor-specific instructions:
- [`main` README](https://github.com/juliusmarkwei/ghost-writer/blob/main/README.md) - Vim
- [`nano` README](https://github.com/juliusmarkwei/ghost-writer/blob/nano/README.md) - Nano
- [`vs-code` README](https://github.com/juliusmarkwei/ghost-writer/blob/vs-code/README.md) - VS Code

---

## 🐛 Issues & Support

If you encounter problems:
1. Check the troubleshooting section in your branch's README
2. Try switching to `main` branch (most stable)
3. Open an issue on GitHub with your branch name

---

## 🎉 Recommendation

**For most users, we recommend the `main` branch (Vim).** It's the most tested, stable, and works out of the box without any configuration.

If you're new to Vim or prefer something simpler, try the `nano` branch!

Only use `vs-code` if you specifically need VS Code and are willing to configure it properly.
