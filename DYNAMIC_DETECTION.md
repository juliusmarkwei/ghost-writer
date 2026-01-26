# Dynamic Source Detection

## Overview

GhostWriter now uses **intelligent auto-detection** to find source files across various project structures. No more hardcoded paths!

## Detection Strategy

The script searches in this priority order:

### 1️⃣ Nested Patterns (Checked First)

Looks for common entry points in nested directories:

```
src/app/main/index.ts
src/app/main/index.js
src/app/main/main.ts
...
src/app/index.ts
src/main/index.ts
app/main/index.ts
src/server/index.ts
app/server/server.ts
```

**Full pattern list:**
- `src/app/main/`
- `src/app/`
- `src/main/`
- `app/main/`
- `src/server/`
- `app/server/`

### 2️⃣ Common Directories (Priority Order)

Searches these directories for entry point files:

1. `src/` - Most common for source code
2. `app/` - Next.js, NestJS apps
3. `lib/` - Library packages
4. `packages/` - Monorepos
5. `server/` - Backend code
6. `client/` - Frontend code
7. `api/` - API services
8. (root) - Root-level files

### 3️⃣ Entry Point Files (Priority Order)

Looks for these filenames:

1. `index.ts` - Most common TypeScript entry
2. `index.js` - Most common JavaScript entry
3. `main.ts` - Alternative TypeScript entry
4. `main.js` - Alternative JavaScript entry
5. `app.ts` - Application entry
6. `app.js` - Application entry
7. `server.ts` - Server entry
8. `server.js` - Server entry

### 4️⃣ Directory Fallback

If no specific entry point is found, searches for **any directory** containing code files (`.ts`, `.js`, `.tsx`, `.jsx`) and uses that entire directory.

### 5️⃣ Embedded Test Source

If absolutely nothing is found, generates a built-in TypeScript test file.

## Supported Project Structures

### ✅ Node.js / Express
```
project/
├── src/index.js          ← Detected
├── src/app.js
└── package.json
```

### ✅ Next.js App Router
```
project/
├── app/
│   └── page.tsx          ← Detected (directory)
├── src/app/              ← Alternative
└── package.json
```

### ✅ React / Vite
```
project/
├── src/
│   ├── main.tsx          ← Detected
│   └── App.tsx
└── package.json
```

### ✅ NestJS
```
project/
├── src/
│   └── main.ts           ← Detected
├── src/app/
└── nest-cli.json
```

### ✅ Angular
```
project/
├── src/
│   ├── main.ts           ← Detected
│   └── app/
└── angular.json
```

### ✅ Monorepo (with packages/)
```
project/
├── packages/
│   ├── server/index.ts   ← Detected
│   └── client/
└── package.json
```

### ✅ Backend API
```
project/
├── api/
│   └── server.ts         ← Detected
├── lib/
└── package.json
```

### ✅ Library Package
```
project/
├── lib/
│   └── index.ts          ← Detected
├── src/
└── package.json
```

### ✅ Custom Structure (No Standard Entry)
```
project/
├── src/
│   ├── utils.ts          ← Detected (directory)
│   ├── helpers.ts
│   └── models.ts
└── package.json
```

### ✅ Root-Level Files
```
project/
├── index.js              ← Detected
├── server.js
└── package.json
```

## Testing

### Test Results

All structures tested and working:

```bash
✅ src/app/main/index.ts    → Detected nested pattern
✅ lib/index.js             → Detected common directory
✅ packages/server.ts       → Detected packages directory
✅ index.js                 → Detected root level
✅ src/utils.ts (+ others)  → Detected directory with code files
```

### Manual Testing

Create test projects:

```bash
# Test 1: Nested pattern
mkdir -p test1/src/app/main && touch test1/src/app/main/index.ts
cd test1
ghost-writer --duration 1

# Test 2: App directory
mkdir -p test2/app && touch test2/app/main.ts
cd test2
ghost-writer --duration 1

# Test 3: Library
mkdir -p test3/lib && touch test3/lib/index.js
cd test3
ghost-writer --duration 1

# Test 4: API server
mkdir -p test4/api && touch test4/api/server.ts
cd test4
ghost-writer --duration 1

# Test 5: Custom structure
mkdir -p test5/src && touch test5/src/{utils,helpers,models}.ts
cd test5
ghost-writer --duration 1
```

## Console Output

When auto-detecting, you'll see:

```
🔍 Auto-detecting source files...
✅ Using detected default source: /path/to/project/src/index.ts
```

Or for directories:

```
🔍 Auto-detecting source files...
✅ Found code files in: src/
✅ Using detected default source: /path/to/project/src
```

Or if nothing found:

```
🔍 Auto-detecting source files...
⚠️  No default source file found. Generating test source...
✅ Generated test source at: /path/to/project/default_simulation_source.ts
```

## Implementation Details

### Arrays Used

```bash
# Directories (priority order)
COMMON_DIRS=("src" "app" "lib" "packages" "server" "client" "api" "")

# Entry point filenames
COMMON_FILES=("index.ts" "index.js" "main.ts" "main.js"
              "app.ts" "app.js" "server.ts" "server.js")

# Nested patterns
NESTED_PATTERNS=("src/app/main" "src/app" "src/main"
                 "app/main" "src/server" "app/server")
```

### Search Algorithm

1. **Nested search**: Try all combinations of nested patterns + common files
2. **Directory search**: Try all combinations of common directories + common files
3. **Directory fallback**: Use `find` to locate directories with code files
4. **Generate test**: Create embedded TypeScript test file

### Performance

- **Fast**: Uses bash built-ins and simple file checks
- **No network**: All detection is local
- **Efficient**: Stops searching as soon as a match is found
- **Comprehensive**: Falls back through multiple strategies

## Benefits

### Before (Hardcoded)
```bash
# Only detected these exact paths:
✗ src/app/main/index.ts
✗ src/index.ts
✗ index.ts
```

### After (Dynamic)
```bash
# Detects ANY of these patterns:
✓ 6 nested patterns × 8 file types = 48 combinations
✓ 8 directories × 8 file types = 64 combinations
✓ Any directory with .ts/.js/.tsx/.jsx files
✓ Total: 100+ possible structures
```

## Configuration

### Override Detection

You can always override with `--source`:

```bash
# Force specific file
ghost-writer --source custom/path/to/file.ts

# Force specific directory
ghost-writer --source my-custom-dir/
```

### Extend Patterns

To add more patterns, edit `index.sh` lines 280-287:

```bash
# Add your custom directories
COMMON_DIRS=("src" "app" "lib" "custom" ...)

# Add your custom filenames
COMMON_FILES=("index.ts" "custom.ts" ...)

# Add your custom nested patterns
NESTED_PATTERNS=("src/app/main" "custom/nested" ...)
```

## Edge Cases

### Multiple Matches

If multiple entry points exist, the **first match** (by priority order) is used.

Example:
```
project/
├── src/app/main/index.ts  ← This wins (highest priority)
├── src/index.ts
└── index.ts
```

### No Code Files

If project has no code files at all:
```
🔍 Auto-detecting source files...
⚠️  No default source file found. Generating test source...
✅ Generated test source at: default_simulation_source.ts
```

### Symlinks

The script follows symlinks when checking file existence.

## Future Enhancements

Potential improvements:

1. **Intelligent ranking**: Use file size/modification date to prefer more active files
2. **Configuration file**: Allow `.ghostwriterrc` to specify custom patterns
3. **Multiple files**: Support detecting and cycling through multiple entry points
4. **Language detection**: Prefer files matching project's primary language
5. **Git integration**: Use `.gitignore` to exclude certain directories

## Summary

The new dynamic detection makes GhostWriter **"just work"** with virtually any JavaScript/TypeScript project structure, eliminating the need for manual `--source` specification in most cases.

**Detected automatically:**
- ✅ Node.js projects
- ✅ React/Vue/Angular apps
- ✅ Next.js/Nuxt apps
- ✅ Express/NestJS servers
- ✅ Monorepos
- ✅ Library packages
- ✅ Custom structures
- ✅ And more!
