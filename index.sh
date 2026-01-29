#!/bin/bash

# Defaults
DURATION_MINUTES=30
MIN_DELAY_MS=150
MAX_DELAY_MS=500
SUBPROJECT_NAME="simulation-subproject"
SOURCE_FILE_RELATIVE=""
MOUSE_MONITOR_ACTIVE=false

# Browser Search Configuration
ENABLE_BROWSER_SEARCH=true
BROWSER_SEARCH_FREQUENCY=25
LAST_SEARCH_TIME=0
SEARCH_COOLDOWN=60

# Embedded Comprehensive Source (TypeScript)
read -r -d '' DEFAULT_CONTENT << 'EOF'
interface VoidConfig {
    redundancyLevel: number;
    echoChamberEnabled: boolean;
    maxEntropy: number;
}

class DimensionlessVoid {
    private capacity: number;
    private items: any[] = [];

    constructor(capacity: number = Infinity) {
        this.capacity = capacity;
        console.log(`[Void] Initialized with capacity: ${this.capacity}`);
    }

    public absorb(matter: any): void {
        if (this.items.length < this.capacity) {
            this.items.push(matter);
            this.processMatter(matter);
        } else {
            console.warn('[Void] Capacity reached. Rejecting matter.');
        }
    }

    private processMatter(matter: any): void {
        // Complex calculation to determine the nothingness of the matter
        let entropy = 0;
        for (let i = 0; i < 100; i++) {
            entropy += Math.random();
            if (entropy > 50) {
                entropy -= 10;
            }
        }
        console.log(`[Void] Processed matter. Resulting entropy: ${entropy}`);
    }
}

class EnterpriseNothingService {
    private config: VoidConfig;
    private voidInstance: DimensionlessVoid;

    constructor(config: VoidConfig) {
        this.config = config;
        this.voidInstance = new DimensionlessVoid(1000);
    }

    public async initialize(): Promise<void> {
        console.log('Initializing Enterprise Nothing Service...');
        await this.simulateStartupSequence();
        console.log('Service ready to do nothing.');
    }

    private async simulateStartupSequence(): Promise<void> {
        const steps = ['Loading modules', 'Connecting to ether', 'Calibrating void', 'Updating cache'];

        for (const step of steps) {
            console.log(`[Startup] ${step}...`);
            await this.sleep(200);
            if (this.config.redundancyLevel > 5) {
                console.log(`[Startup] Verifying ${step}... (Redundant Check)`);
            }
        }
    }

    public executeNothingLoop(): void {
        if (this.config.echoChamberEnabled) {
            console.log('Echo chamber active. Repeating nothing.');
        }

        for (let i = 0; i < this.config.maxEntropy; i++) {
            const meaninglessData = {
                id: i,
                timestamp: Date.now(),
                value: Math.random().toString(36).substring(7)
            };

            this.voidInstance.absorb(meaninglessData);

            if (i % 10 === 0) {
                console.log(`[Loop] Processed ${i} units of nothing.`);
            }
        }
    }

    private sleep(ms: number): Promise<void> {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
}

const defaultConfig: VoidConfig = {
    redundancyLevel: 10,
    echoChamberEnabled: true,
    maxEntropy: 50
};

async function main() {
    console.log('--- STARTING NON-OPERATION ---');
    const service = new EnterpriseNothingService(defaultConfig);
    try {
        await service.initialize();
        service.executeNothingLoop();
    } catch (error) {
        console.error('Failed to do nothing:', error);
    } finally {
        console.log('--- END OF NON-OPERATION ---');
    }
}

main();
EOF

# Help Message
function show_help {
    echo "Usage: ghost-writer [options]"
    echo ""
    echo "Options:"
    echo "  -d, --duration <min>      Duration in minutes (default: 30)"
    echo "  --min-delay <ms>          Minimum delay between keystrokes (default: 150)"
    echo "  --max-delay <ms>          Maximum delay between keystrokes (default: 500)"
    echo "  --name <name>             Name of subproject (default: simulation-subproject)"
    echo "  --source <path>           Relative or absolute path to source file/directory"
    echo "  --enable-browser-search   Enable browser search feature (default)"
    echo "  --disable-browser-search  Disable browser search feature"
    echo "  --search-frequency <n>    Search trigger probability % (default: 25)"
    echo "  -h, --help                Show this help message"
    echo ""
    echo "Examples:"
    echo "  ghost-writer --duration 60                      # Run for 1 hour with default source"
    echo "  ghost-writer --min-delay 50 --max-delay 150     # Type faster"
    echo "  ghost-writer --disable-browser-search           # Disable browser searches"
    echo "  ghost-writer --search-frequency 50              # More frequent searches (50%)"
    echo "  ghost-writer --name my-project                  # Custom subproject name"
    echo "  ghost-writer --source src/utils.ts              # Type a specific file"
    echo "  ghost-writer --source src/                      # Process all files in directory"
    exit 0
}

# Argument Parsing
USER_PROVIDED_SOURCE=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--duration) DURATION_MINUTES="$2"; shift ;;
        --min-delay) MIN_DELAY_MS="$2"; shift ;;
        --max-delay) MAX_DELAY_MS="$2"; shift ;;
        --name) SUBPROJECT_NAME="$2"; shift ;;
        --source) SOURCE_FILE_RELATIVE="$2"; USER_PROVIDED_SOURCE=true; shift ;;
        --enable-browser-search) ENABLE_BROWSER_SEARCH="true" ;;
        --disable-browser-search) ENABLE_BROWSER_SEARCH="false" ;;
        --search-frequency) BROWSER_SEARCH_FREQUENCY="$2"; shift ;;
        -h|--help) show_help ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# duration to seconds for standard bash arithmetic
DURATION_SEC=$((DURATION_MINUTES * 60))

# Project Detection
function find_project_root {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/package.json" ]]; then
            echo "$dir"
            return
        fi
        dir="$(dirname "$dir")"
    done
    echo "$PWD" # Default to CWD if not found
}

ROOT_PATH=$(find_project_root)
echo "Detected project root: $ROOT_PATH"

# Validating OS
OS_NAME=$(uname -s)
echo "Detected OS: $OS_NAME"

START_TIME=$(date +%s)

# Dependency Check & Installation
function check_dependencies {
    echo "Checking dependencies for $OS_NAME..."

    if [[ "$OS_NAME" == "Linux" ]]; then
        if ! command -v xdotool &> /dev/null; then
            echo "⚠️  'xdotool' is not installed. Attempting to install..."
            if command -v apt-get &> /dev/null; then
                sudo apt-get update && sudo apt-get install -y xdotool
            elif command -v dnf &> /dev/null; then
                sudo dnf install -y xdotool
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm xdotool
            elif command -v yum &> /dev/null; then
                sudo yum install -y xdotool
            else
                echo "❌  Error: 'xdotool' not found and could not detect package manager."
                echo "    Please install 'xdotool' manually."
                exit 1
            fi

            # Verify after installation
            if ! command -v xdotool &> /dev/null; then
                echo "❌  Failed to install 'xdotool'. Please install it manually."
                exit 1
            fi
            echo "✅  'xdotool' installed successfully."
        else
            echo "✅  'xdotool' is already installed."
        fi
    elif [[ "$OS_NAME" != "Darwin" ]]; then
        # Windows/Git Bash/WSL
        if ! command -v powershell.exe &> /dev/null; then
            echo "❌  Error: 'powershell.exe' not found."
            echo "    This script requires PowerShell to simulate typing on Windows."
            exit 1
        else
             echo "✅  'powershell.exe' found."
        fi
    else
        # macOS - no dependencies to install
        if ! command -v osascript &> /dev/null; then
             echo "❌  Error: 'osascript' not found (this is unexpected on macOS)."
             exit 1
        fi
        echo "✅  'osascript' found."
    fi

    # VS Code Requirement (All Platforms)
    if ! command -v code &> /dev/null; then
        echo "❌  Error: 'code' command not found."
        echo "    Please install VS Code and ensure the 'code' command is in your PATH:"
        if [[ "$OS_NAME" == "Darwin" ]]; then
            echo "    1. Download from https://code.visualstudio.com/"
            echo "    2. Open VS Code and run: Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
        elif [[ "$OS_NAME" == "Linux" ]]; then
            echo "    1. Download from https://code.visualstudio.com/"
            echo "    2. Or install via snap: sudo snap install --classic code"
        else
            echo "    Download from https://code.visualstudio.com/"
        fi
        exit 1
    fi
    echo "✅  'code' command found."
}

check_dependencies

# Source Path Handling
if [[ "$USER_PROVIDED_SOURCE" == "true" ]]; then
    # User specified a source - validate it exists
    # Handle both absolute and relative paths
    if [[ "$SOURCE_FILE_RELATIVE" == /* ]]; then
        # Absolute path
        SOURCE_PATH="$SOURCE_FILE_RELATIVE"
    else
        # Relative path
        SOURCE_PATH="$ROOT_PATH/$SOURCE_FILE_RELATIVE"
    fi

    if [[ ! -e "$SOURCE_PATH" ]]; then
        echo "❌  Error: Specified source '$SOURCE_PATH' does not exist."
        exit 1
    fi

    if [[ -d "$SOURCE_PATH" ]]; then
        echo "✅ Using user-specified directory: $SOURCE_PATH"
    else
        echo "✅ Using user-specified file: $SOURCE_PATH"
    fi
else
    # No source specified - try to auto-detect using common patterns
    SOURCE_PATH=""
    FOUND_DEFAULT=false

    # Common directories to check (in priority order)
    COMMON_DIRS=("src" "app" "apps" "lib" "libs" "packages" "server" "client" "api" "")

    # Common entry point filenames (in priority order)
    COMMON_FILES=("index.ts" "index.js" "main.ts" "main.js" "app.ts" "app.js" "server.ts" "server.js")

    # Also check nested patterns
    NESTED_PATTERNS=("src/app/main" "src/app" "src/main" "app/main" "src/server" "app/server")

    echo "🔍 Auto-detecting source files..."

    # First, try nested patterns with common files
    for pattern in "${NESTED_PATTERNS[@]}"; do
        for file in "${COMMON_FILES[@]}"; do
            if [[ -f "$ROOT_PATH/$pattern/$file" ]]; then
                SOURCE_PATH="$ROOT_PATH/$pattern/$file"
                FOUND_DEFAULT=true
                break 2
            fi
        done
    done

    # If not found, try common directories with common files
    if [[ "$FOUND_DEFAULT" == "false" ]]; then
        for dir in "${COMMON_DIRS[@]}"; do
            for file in "${COMMON_FILES[@]}"; do
                if [[ -n "$dir" ]]; then
                    test_path="$ROOT_PATH/$dir/$file"
                else
                    test_path="$ROOT_PATH/$file"
                fi

                if [[ -f "$test_path" ]]; then
                    SOURCE_PATH="$test_path"
                    FOUND_DEFAULT=true
                    break 2
                fi
            done
        done
    fi

    # If still not found, try to use first directory with code files
    if [[ "$FOUND_DEFAULT" == "false" ]]; then
        for dir in "${COMMON_DIRS[@]}"; do
            if [[ -z "$dir" ]]; then continue; fi

            test_dir="$ROOT_PATH/$dir"
            if [[ -d "$test_dir" ]]; then
                # Check if directory has any code files
                if find "$test_dir" -maxdepth 3 -type f \( -name "*.ts" -o -name "*.js" -o -name "*.tsx" -o -name "*.jsx" \) -print -quit | grep -q .; then
                    SOURCE_PATH="$test_dir"
                    FOUND_DEFAULT=true
                    echo "✅ Found code files in: $dir/"
                    break
                fi
            fi
        done
    fi

    if [[ "$FOUND_DEFAULT" == "false" ]]; then
        echo "⚠️  No default source file found. Generating test source..."
        ECHO_FILE="$ROOT_PATH/default_simulation_source.ts"
        echo "$DEFAULT_CONTENT" > "$ECHO_FILE"
        SOURCE_PATH="$ECHO_FILE"
        GENERATED_SOURCE=true
        echo "✅ Generated test source at: $SOURCE_PATH"
    else
        echo "✅ Using detected default source: $SOURCE_PATH"
    fi
fi

SUBPROJECT_PATH="$ROOT_PATH/$SUBPROJECT_NAME"
KNOWN_EDITOR_APP=""

# Function to save the current file in VS Code
function save_file {
    echo "💾 Saving file (Cmd/Ctrl+S)..."

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # macOS: Cmd+S
        osascript -e 'tell application "System Events" to keystroke "s" using command down' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        # Linux: Ctrl+S
        xdotool key ctrl+s
    else
        # Windows: Ctrl+S
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.SendKeys]::SendWait('^s')
        " > /dev/null 2>&1
    fi

    sleep 0.2
}

# Function to activate browser window
function activate_browser {
    if [[ "$OS_NAME" == "Darwin" ]]; then
        # Try common browsers in order of popularity
        osascript -e 'tell application "Google Chrome" to activate' 2>/dev/null || \
        osascript -e 'tell application "Safari" to activate' 2>/dev/null || \
        osascript -e 'tell application "Firefox" to activate' 2>/dev/null || \
        osascript -e 'tell application "Microsoft Edge" to activate' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        # Try to activate browser windows
        xdotool search --name "Chrome" windowactivate 2>/dev/null || \
        xdotool search --name "Firefox" windowactivate 2>/dev/null || \
        xdotool search --name "Safari" windowactivate 2>/dev/null
    else
        # Windows - Alt+Tab to switch
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.SendKeys]::SendWait('%{TAB}')
        " > /dev/null 2>&1
    fi
}

# Function to scroll page slowly (simulate reading)
function scroll_page {
    local num_scrolls="$1"

    for (( i=0; i<num_scrolls; i++ )); do
        if [[ "$OS_NAME" == "Darwin" ]]; then
            # Scroll down using down arrow or space
            osascript -e 'tell application "System Events" to key code 125' 2>/dev/null  # Down arrow
        elif [[ "$OS_NAME" == "Linux" ]]; then
            xdotool key Down 2>/dev/null
        else
            powershell.exe -Command "
                Add-Type -AssemblyName System.Windows.Forms
                [System.Windows.Forms.SendKeys]::SendWait('{DOWN}')
            " > /dev/null 2>&1
        fi

        # Random delay between scrolls (0.3-0.8s) - simulates reading
        local delay=$(awk "BEGIN {print (0.3 + rand() * 0.5)}")
        sleep "$delay"
    done
}

# Function to click first search result (press Enter or Tab+Enter)
function click_first_link {
    echo "   🖱️  Clicking first search result..."

    # Small delay before clicking
    sleep 0.5

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # Press Tab to focus first link, then Enter to click
        osascript -e 'tell application "System Events" to keystroke tab' 2>/dev/null
        sleep 0.3
        osascript -e 'tell application "System Events" to keystroke return' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool key Tab 2>/dev/null
        sleep 0.3
        xdotool key Return 2>/dev/null
    else
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.SendKeys]::SendWait('{TAB}')
            Start-Sleep -Milliseconds 300
            [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
        " > /dev/null 2>&1
    fi
}

# Function to minimize or close browser
function minimize_browser {
    echo "   ↙️  Minimizing browser..."

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # Cmd+M to minimize window
        osascript -e 'tell application "System Events" to keystroke "m" using command down' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        # Minimize active window
        xdotool getactivewindow windowminimize 2>/dev/null
    else
        # Windows - Minimize window
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.SendKeys]::SendWait('%{F9}')
        " > /dev/null 2>&1
    fi
}

# Function to open browser with search query and simulate realistic interaction
function open_browser_search {
    local query="$1"
    local encoded_query=$(echo "$query" | sed 's/ /+/g')
    local search_url="https://www.google.com/search?q=$encoded_query"

    echo "🔍  Opening browser: '$query'"

    # Step 1: Open browser with search
    if [[ "$OS_NAME" == "Darwin" ]]; then
        open "$search_url" 2>/dev/null &
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdg-open "$search_url" 2>/dev/null &
    else
        powershell.exe -Command "Start-Process '$search_url'" > /dev/null 2>&1 &
    fi

    # Step 2: Wait for browser to open and page to load
    echo "   ⏳ Waiting for page to load..."
    sleep 3

    # Step 3: Activate browser window
    activate_browser
    sleep 0.5

    # Step 4: Scroll search results (simulate reading results)
    echo "   📜 Scrolling search results..."
    local search_scrolls=$((2 + RANDOM % 3))  # 2-4 scrolls
    scroll_page "$search_scrolls"

    # Step 5: Click on first search result
    click_first_link

    # Step 6: Wait for article/documentation page to load
    echo "   ⏳ Loading article..."
    sleep 2

    # Step 7: Scroll article (simulate reading content)
    echo "   📖 Reading content..."
    local article_scrolls=$((4 + RANDOM % 4))  # 4-7 scrolls
    scroll_page "$article_scrolls"

    # Step 8: Stay on page simulating reading time
    local reading_time=$((3 + RANDOM % 5))  # 3-7 additional seconds
    echo "   👀 Reading for ${reading_time}s..."
    sleep "$reading_time"

    # Step 9: Minimize browser
    minimize_browser
    sleep 0.5

    # Step 10: Refocus editor
    echo "   🔄 Refocusing editor..."
    refocus_app
    sleep 0.5
}

# Function to generate contextual search queries
function generate_contextual_search {
    local source_file="$1"
    local current_line="$2"

    # Detect language from file extension
    local ext="${source_file##*.}"
    local language=""
    case "$ext" in
        ts|tsx) language="TypeScript" ;;
        js|jsx) language="JavaScript" ;;
        py) language="Python" ;;
        go) language="Go" ;;
        rs) language="Rust" ;;
        *) language="Programming" ;;
    esac

    # Extract context from current line if available
    if [[ "$current_line" =~ function[[:space:]]+([a-zA-Z_][a-zA-Z0-9_]*) ]]; then
        echo "$language function ${BASH_REMATCH[1]} best practices"
    elif [[ "$current_line" =~ class[[:space:]]+([a-zA-Z_][a-zA-Z0-9_]*) ]]; then
        echo "$language class design patterns"
    elif [[ "$current_line" =~ import.*from[[:space:]]+[\'\"]([a-zA-Z0-9@/-]+) ]]; then
        echo "${BASH_REMATCH[1]} documentation"
    else
        # Fallback to generic contextual searches
        local SEARCH_QUERIES=(
            "$language best practices 2025"
            "$language performance optimization"
            "$language design patterns"
            "$language error handling"
            "$language testing framework"
            "clean code principles $language"
        )
        local random_idx=$((RANDOM % ${#SEARCH_QUERIES[@]}))
        echo "${SEARCH_QUERIES[$random_idx]}"
    fi
}

# Function to determine if browser search should be triggered
function should_trigger_browser_search {
    local pause_type="$1"

    # Check if feature enabled
    [[ "$ENABLE_BROWSER_SEARCH" != "true" ]] && return 1

    # Check cooldown (avoid spam)
    local current_time=$(date +%s)
    local time_since_last=$((current_time - LAST_SEARCH_TIME))
    [[ $time_since_last -lt $SEARCH_COOLDOWN ]] && return 1

    # Trigger on long or medium pauses with configured probability
    case "$pause_type" in
        long)
            # Higher chance during long pauses (before functions/classes)
            if (( RANDOM % 100 < BROWSER_SEARCH_FREQUENCY * 2 )); then
                return 0
            fi
            ;;
        medium)
            # Normal chance during medium pauses
            if (( RANDOM % 100 < BROWSER_SEARCH_FREQUENCY )); then
                return 0
            fi
            ;;
    esac

    return 1
}

# Function to send forward delete (to remove auto-completed closing chars)
function send_forward_delete {
    local count="${1:-1}"

    if [[ "$OS_NAME" == "Darwin" ]]; then
        for (( i=0; i<count; i++ )); do
            # Key code 117 is Forward Delete on macOS
            osascript -e 'tell application "System Events" to key code 117' 2>/dev/null
            sleep 0.05
        done
    elif [[ "$OS_NAME" == "Linux" ]]; then
        for (( i=0; i<count; i++ )); do
            xdotool key Delete
            sleep 0.05
        done
    else
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            for (\$i = 0; \$i -lt $count; \$i++) {
                [System.Windows.Forms.SendKeys]::SendWait('{DELETE}')
                Start-Sleep -Milliseconds 50
            }
        " > /dev/null 2>&1
    fi
}

# Function to handle VS Code character typing (simplified - no auto-complete handling)
function handle_vscode_char {
    local char="$1"

    # Just type the character - user must disable VS Code auto-complete in settings
    type_char "$char"
}

# Function to type a single character
function type_char {
    local char="$1"

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # Escape special characters for AppleScript
        case "$char" in
            '"')
                # Double quote needs special handling
                osascript -e 'tell application "System Events" to keystroke "\""' 2>/dev/null
                ;;
            '\\')
                # Backslash
                osascript -e 'tell application "System Events" to keystroke "\\"' 2>/dev/null
                ;;
            '$')
                # Dollar sign - use key code 4 with shift for $
                osascript -e 'tell application "System Events" to keystroke "$"' 2>/dev/null
                ;;
            *)
                # All other characters
                osascript -e "tell application \"System Events\" to keystroke \"$char\"" 2>/dev/null
                ;;
        esac
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool type --delay 0 -- "$char"
    else
        local escaped_char="${char//\'/\'\'}"
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.SendKeys]::SendWait('$escaped_char')
        " > /dev/null 2>&1
    fi
}


# Context-aware typing delay calculator
function calculate_typing_delay {
    local char="$1"
    local line="$2"
    local position="$3"

    local base_min=$MIN_DELAY_MS
    local base_max=$MAX_DELAY_MS
    local base_range=$((base_max - base_min))

    # Calculate base delay with random jitter
    local delay=$((base_min + RANDOM % (base_range + 1)))

    # Adjust based on character type
    if [[ "$char" =~ ^[[:space:]]$ ]]; then
        # Whitespace: 2x faster
        delay=$((delay / 2))
    elif [[ "$char" =~ [\(\)\{\}\[\]\;\:\"\'\`\$] ]]; then
        # Special chars: slower
        local slowdown=$((30 + RANDOM % 21))  # +30-50ms
        delay=$((delay + slowdown))
    fi

    # Add complexity penalty for long lines
    local line_len=${#line}
    if [[ $line_len -gt 80 ]]; then
        delay=$((delay + 50))
    fi

    # Random jitter: ±20ms
    local jitter=$((RANDOM % 41 - 20))
    delay=$((delay + jitter))

    # Ensure positive
    if [[ $delay -lt 10 ]]; then
        delay=10
    fi

    echo "$delay"
}

# Detect if we should pause before this line
function should_pause_before_line {
    local line="$1"
    local prev_line="$2"
    local line_number="$3"

    # Skip first line
    if [[ $line_number -eq 1 ]]; then
        echo "none"
        return
    fi

    # Long pause: before major constructs
    if [[ "$line" =~ ^[[:space:]]*(function|class|interface|type|const|let|var|import|export|async|//|/\*|\*/|\}[[:space:]]*$) ]]; then
        echo "long"
        return
    fi

    # Medium pause: after block endings
    if [[ "$prev_line" =~ [\}\;][[:space:]]*$ ]] && [[ -z "${line// /}" ]]; then
        echo "medium"
        return
    fi

    # Short pause: after blank lines
    if [[ -z "${prev_line// /}" ]] && [[ -n "${line// /}" ]]; then
        echo "short"
        return
    fi

    # Micro pause: random 20% chance
    if (( RANDOM % 5 == 0 )); then
        echo "micro"
        return
    fi

    echo "none"
}

# Execute a pause with appropriate duration
function execute_pause {
    local pause_type="$1"
    local line="$2"

    local duration=0

    case "$pause_type" in
        long)
            duration=$(awk "BEGIN {print (1.5 + rand() * 2.5)}")  # 1.5-4s
            ;;
        medium)
            duration=$(awk "BEGIN {print (0.8 + rand() * 1.2)}")  # 0.8-2s
            ;;
        short)
            duration=$(awk "BEGIN {print (0.3 + rand() * 0.5)}")  # 0.3-0.8s
            ;;
        micro)
            duration=$(awk "BEGIN {print (0.1 + rand() * 0.2)}")  # 0.1-0.3s
            ;;
    esac

    if [[ "$pause_type" != "micro" ]]; then
        local preview="${line:0:50}"
        if [[ ${#line} -gt 50 ]]; then
            preview="${preview}..."
        fi
        echo "🧠  Pausing (${pause_type}): ${duration}s before '${preview}'"
    fi

    sleep "$duration"
}

# Simulate a typo with backspace and correction
function simulate_typo {
    local line="$1"
    local position="$2"

    local line_len=${#line}

    # Skip typos near boundaries or on whitespace
    if [[ $position -lt 3 ]] || [[ $position -gt $((line_len - 3)) ]]; then
        return
    fi

    local char="${line:$position:1}"
    if [[ "$char" =~ ^[[:space:]]$ ]]; then
        return
    fi

    # 5% chance of typo
    if (( RANDOM % 20 != 0 )); then
        return
    fi

    # Determine how many chars to delete (2-4)
    local delete_count=$((2 + RANDOM % 3))

    echo "⌫  Simulating typo (backspace $delete_count chars)..."

    # Backspace
    for (( i=0; i<delete_count; i++ )); do
        if [[ "$OS_NAME" == "Darwin" ]]; then
            osascript -e 'tell application "System Events" to key code 51' 2>/dev/null  # Backspace
        elif [[ "$OS_NAME" == "Linux" ]]; then
            xdotool key BackSpace
        else
            powershell.exe -Command "
                Add-Type -AssemblyName System.Windows.Forms
                [System.Windows.Forms.SendKeys]::SendWait('{BACKSPACE}')
            " > /dev/null 2>&1
        fi
        sleep 0.08
    done

    # Pause to "realize" mistake
    local pause=$(awk "BEGIN {print (0.2 + rand() * 0.3)}")  # 0.2-0.5s
    sleep "$pause"

    # Retype the deleted characters
    local start_pos=$((position - delete_count + 1))
    for (( i=0; i<delete_count; i++ )); do
        local retype_char="${line:$((start_pos + i)):1}"
        type_char "$retype_char"
        sleep 0.15
    done
}

# Function to type text character by character with human-like behavior
function type_text {
    local line="$1"
    local prev_line="$2"
    local line_number="$3"
    local source_file="${4:-}"

    # Check for pause before line
    local pause_type=$(should_pause_before_line "$line" "$prev_line" "$line_number")
    if [[ "$pause_type" != "none" ]]; then
        # Check if should trigger browser search
        if should_trigger_browser_search "$pause_type"; then
            local search_term=$(generate_contextual_search "$source_file" "$line")
            open_browser_search "$search_term"
            LAST_SEARCH_TIME=$(date +%s)
            # Execute shorter pause after browser opens
            execute_pause "short" "$line"
        else
            # Normal pause without browser
            execute_pause "$pause_type" "$line"
        fi
    fi

    local len=${#line}

    # Type character by character
    for (( i=0; i<len; i++ )); do
        local char="${line:$i:1}"

        # Use VS Code-aware typing
        handle_vscode_char "$char"

        # Occasionally simulate typos (not on whitespace)
        if [[ ! "$char" =~ ^[[:space:]]$ ]]; then
            simulate_typo "$line" "$i"
        fi

        # Context-aware delay
        local delay_ms=$(calculate_typing_delay "$char" "$line" "$i")
        local delay_sec=$(awk "BEGIN {print $delay_ms/1000}")
        sleep "$delay_sec"
    done

    # Press Enter at the end of the line
    sleep 0.1
    if [[ "$OS_NAME" == "Darwin" ]]; then
        osascript -e 'tell application "System Events" to key code 36' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool key Return
    else
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
        " > /dev/null 2>&1
    fi
    sleep 0.1
}


# Mouse Position Helper
function get_mouse_pos {
    if [[ "$OS_NAME" == "Darwin" ]]; then
        python3 -c "
import ctypes
import ctypes.util

cg_path = ctypes.util.find_library('CoreGraphics')
if not cg_path:
    print('0,0')
    exit()

cg = ctypes.cdll.LoadLibrary(cg_path)

class CGPoint(ctypes.Structure):
    _fields_ = [('x', ctypes.c_double), ('y', ctypes.c_double)]

cg.CGEventCreate.restype = ctypes.c_void_p
cg.CGEventCreate.argtypes = [ctypes.c_void_p]
cg.CGEventGetLocation.restype = CGPoint
cg.CGEventGetLocation.argtypes = [ctypes.c_void_p]

event = cg.CGEventCreate(None)
loc = cg.CGEventGetLocation(event)
print(f'{int(loc.x)},{int(loc.y)}')
" 2>/dev/null || echo "0,0"

    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool getmouselocation --shell 2>/dev/null | grep -E "X=|Y=" | tr '\n' ',' | sed 's/X=//;s/Y=//;s/,$//'
    else
        powershell.exe -Command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; \$pos = [System.Windows.Forms.Cursor]::Position; Write-Host \"\$(\$pos.X),\$(\$pos.Y)\"" 2>/dev/null | tr -d '\r'
    fi
}

# Improved mouse monitor with proper termination
function monitor_mouse {
    local initial_pos="$1"
    local main_pid="$2"

    echo "🖱️  Mouse monitor started (PID: $, monitoring: $main_pid)"

    while true; do
        # Check if main process is still running
        if ! kill -0 "$main_pid" 2>/dev/null; then
            echo "🖱️  Main process ended, stopping mouse monitor"
            break
        fi

        current_pos=$(get_mouse_pos)

        # Check for movement (with better validation)
        if [[ -n "$current_pos" && "$current_pos" != "0,0" && "$current_pos" != "$initial_pos" ]]; then
            echo ""
            echo "🛑  Mouse movement detected! ($initial_pos → $current_pos)"
            echo "🛑  Terminating simulation..."
            kill -TERM "$main_pid" 2>/dev/null
            MOUSE_MONITOR_ACTIVE=false
            exit 0
        fi
        sleep 0.5
    done

    echo "🖱️  Mouse monitor ended"
}

# Active Application Helper
function get_active_app {
    if [[ "$OS_NAME" == "Darwin" ]]; then
        osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        id=$(xdotool getactivewindow 2>/dev/null)
        if [[ -n "$id" ]]; then
            xdotool getwindowclassname "$id" 2>/dev/null
        fi
    else
        echo "Windows_Generic"
    fi
}

function is_safe_app {
    local app_name="$1"
    case "$app_name" in
        *Code*|*VSCode*|*code*|*vscode*|*Cursor*|*Windsurf*|*Electron*|*iTerm*|*Terminal*|*Warp*|*Alacritty*|*Hyper*|*kitty*|*Windows_Generic*)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

function refocus_app {
    local app_name="$1"

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # For macOS, try to activate Terminal (for Nano)
        osascript -e 'tell application "Terminal" to activate' 2>/dev/null || \
        osascript -e "tell application \"$app_name\" to activate" 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool search --name "$app_name" windowactivate 2>/dev/null || xdotool search --class "$app_name" windowactivate 2>/dev/null
    else
        powershell.exe -Command "(New-Object -ComObject WScript.Shell).AppActivate('$app_name')" 2>/dev/null
    fi
}


function wait_for_safe_focus {
    local current_app=$(get_active_app)

    # If currently safe, update our tracker and return immediately
    if is_safe_app "$current_app"; then
        if [[ -z "$KNOWN_EDITOR_APP" ]]; then
            KNOWN_EDITOR_APP="$current_app"
            echo "✅ Detected editor: $current_app"
        fi
        return 0
    fi

    # Not in safe app - try to refocus if we know a good one
    if [[ -n "$KNOWN_EDITOR_APP" ]]; then
         echo -ne "\r🔄  Refocusing editor...   "
         refocus_app "$KNOWN_EDITOR_APP"
         sleep 0.5

         current_app=$(get_active_app)
         if is_safe_app "$current_app"; then
             echo -ne "\r                                                                           \r"
             return 0
         fi
    fi

    # Wait for user to focus a safe app
    local last_log=""
    while true; do
        current_app=$(get_active_app)
        if is_safe_app "$current_app"; then
            KNOWN_EDITOR_APP="$current_app"
            echo -ne "\r                                                                           \r"
            echo "✅ Editor focused: $current_app"
            break
        fi

        if [[ "$current_app" != "$last_log" ]]; then
             echo ""
             echo "🚫  Unsupported App: '$current_app'"
             last_log="$current_app"
        fi

        echo -ne "\r⏳  Paused. Waiting for safe app...   "
        sleep 1
    done
}

# Cleanup handler for graceful shutdown
function cleanup {
    echo ""
    echo "🧹 Cleaning up..."
    if [[ -n "$MONITOR_PID" ]] && kill -0 "$MONITOR_PID" 2>/dev/null; then
        kill "$MONITOR_PID" 2>/dev/null
        wait "$MONITOR_PID" 2>/dev/null
    fi
    MOUSE_MONITOR_ACTIVE=false
    exit 0
}

trap cleanup SIGINT SIGTERM

# VS Code files are opened individually with code -r to reuse window
function open_editor_workspace {
    echo "📂 Ready to open files in VS Code..."
    echo "   (Files will open in VS Code with window reuse)"
}


# Simulate typing for a single file
function simulate_typing_session {
    local source_file="$1"
    local is_first_file="$2"

    local filename=$(basename "$source_file")
    local extension="${filename##*.}"
    if [[ "$filename" == "$extension" ]]; then extension="txt"; fi

    local unique_id="$(date +%s)_$RANDOM"
    local target_file="$SUBPROJECT_PATH/${unique_id}_${filename}"

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "STEP 1: Creating file..."
    touch "$target_file"

    if [[ ! -f "$target_file" ]]; then
        echo "❌ ERROR: Failed to create file: $target_file"
        return 1
    fi
    echo "✅ File created: $target_file"

    echo ""
    echo "STEP 2: Opening in VS Code..."

    # Open file in VS Code (reuse existing window)
    code -r "$target_file"

    # Platform-specific window activation and maximization
    if [[ "$OS_NAME" == "Darwin" ]]; then
        # macOS: Activate and maximize VS Code
        osascript -e 'tell application "Visual Studio Code" to activate' 2>/dev/null
        sleep 0.5
        # Maximize window
        osascript -e '
            tell application "System Events"
                tell process "Visual Studio Code"
                    set frontWindow to first window
                    set position of frontWindow to {0, 0}
                    try
                        set size of frontWindow to {1920, 1080}
                    end try
                end tell
            end tell
        ' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        # Linux: Activate and maximize VS Code
        sleep 0.5
        if command -v wmctrl &> /dev/null; then
            wmctrl -a "Visual Studio Code" 2>/dev/null
            wmctrl -r "Visual Studio Code" -b add,maximized_vert,maximized_horz 2>/dev/null
        elif command -v xdotool &> /dev/null; then
            sleep 0.3
            xdotool search --name "Visual Studio Code" windowactivate 2>/dev/null
            xdotool getactivewindow windowsize 100% 100% 2>/dev/null
        fi
    else
        # Windows: Activate and maximize
        sleep 0.5
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            \$hwnd = [System.Diagnostics.Process]::GetProcessesByName('Code') | Select-Object -First 1 -ExpandProperty MainWindowHandle
            if (\$hwnd) {
                [void][System.Windows.Forms.SendKeys]::SendWait('%{TAB}')
                Start-Sleep -Milliseconds 300
                [void][System.Windows.Forms.SendKeys]::SendWait('#{UP}')
            }
        " 2>/dev/null
    fi

    echo ""
    echo "STEP 3: Waiting for you to focus VS Code..."
    if [[ "$is_first_file" == "true" ]]; then
        echo "⏳ Please click on the VS Code window (3 seconds)..."
        sleep 3
    else
        echo "⏳ Please click on the VS Code window (2 seconds)..."
        sleep 2
    fi

    echo ""
    echo "STEP 4: Checking if VS Code is focused..."
    wait_for_safe_focus

    echo ""
    echo "STEP 5: Starting to type!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Start mouse monitor if not already active
    if [[ "$MOUSE_MONITOR_ACTIVE" == "false" ]]; then
        local initial_mouse=$(get_mouse_pos)
        monitor_mouse "$initial_mouse" "$$" &
        MOUSE_MONITOR_PID=$!
        MOUSE_MONITOR_ACTIVE=true
    fi

    echo "✍️  Typing content from $source_file..."

    local line_count=0
    local prev_line=""
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Check if we should continue
        if ! kill -0 $$ 2>/dev/null; then
            break
        fi

        line_count=$((line_count + 1))

        # Check if 20 seconds have passed since last save
        local current_time=$(date +%s)
        local time_since_save=$((current_time - last_save_time))

        if [[ "$time_since_save" -ge 20 ]]; then
            save_file
            last_save_time=$(date +%s)
        fi

        # Check focus before typing each line
        wait_for_safe_focus

        # Type the line with human-like behavior
        type_text "$line" "$prev_line" "$line_count" "$source_file"
        prev_line="$line"
        sleep 0.1
    done < "$source_file"

    # Final save at the end
    echo "💾 Final save..."
    save_file

    echo "✅ Completed typing $(basename "$source_file") ($line_count lines)"
}

# Main Loop - Process cycles
function main_loop {
    local FIRST_CYCLE=true
    local CYCLE_COUNT=0

    while true; do
        CURRENT_TIME=$(date +%s)
        ELAPSED=$((CURRENT_TIME - START_TIME))
        if [[ "$ELAPSED" -ge "$DURATION_SEC" ]]; then
            echo "⏰  Duration reached. Exiting."
            cleanup
            break
        fi

        CYCLE_COUNT=$((CYCLE_COUNT + 1))
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🔄 Starting cycle #$CYCLE_COUNT"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

        # Cleanup and recreate subproject directory
        if [[ -d "$SUBPROJECT_PATH" ]]; then
            echo "🗑️  Cleaning old subproject files..."
            rm -rf "$SUBPROJECT_PATH"
        fi
        mkdir -p "$SUBPROJECT_PATH"
        echo "📁 Created subproject directory: $SUBPROJECT_PATH"

        # Build File List based on whether SOURCE_PATH is file or directory
        FILES_TO_PROCESS=()
        if [[ -d "$SOURCE_PATH" ]]; then
            echo "📁 Processing directory: $SOURCE_PATH"
            while IFS= read -r -d '' file; do
                FILES_TO_PROCESS+=("$file")
            done < <(find "$SOURCE_PATH" -type f ! -path '*/.*' ! -path '*/node_modules/*' -print0)
        else
            echo "📄 Processing single file: $SOURCE_PATH"
            FILES_TO_PROCESS+=("$SOURCE_PATH")
        fi

        echo "📋 Files to process in this cycle: ${#FILES_TO_PROCESS[@]}"

        local file_index=0
        local successfully_typed=false

        for file in "${FILES_TO_PROCESS[@]}"; do
             # Check time limit before each file
             CURRENT_TIME=$(date +%s)
             if [[ $((CURRENT_TIME - START_TIME)) -ge "$DURATION_SEC" ]]; then
                 echo "⏰  Time limit reached during cycle"
                 break
             fi

             file_index=$((file_index + 1))
             echo ""
             echo "➡️  Processing file $file_index/${#FILES_TO_PROCESS[@]}: $(basename "$file")"

             local is_first_file="false"
             if [[ "$FIRST_CYCLE" == "true" ]] && [[ "$file_index" -eq 1 ]]; then
                 is_first_file="true"
             fi

             # Call typing function and check if it succeeded
             if simulate_typing_session "$file" "$is_first_file"; then
                 successfully_typed=true
                 echo "✅ File processed successfully"
             else
                 echo "❌ File processing failed - stopping cycle"
                 break
             fi

             # Small delay between files
             if [[ "$file_index" -lt "${#FILES_TO_PROCESS[@]}" ]]; then
                 echo "⏸️  Pausing 3 seconds before next file..."
                 sleep 3
             fi
        done

        # Only continue cycling if typing was successful
        if [[ "$successfully_typed" == "false" ]]; then
            echo ""
            echo "❌ ERROR: No files were successfully typed in this cycle!"
            echo "❌ This usually means:"
            echo "   1. The typing function encountered an error"
            echo "   2. VS Code is not properly focused or installed"
            echo "   3. Permissions are not granted (macOS Accessibility)"
            echo ""
            echo "Stopping to prevent infinite loop..."
            cleanup
            exit 1
        fi

        FIRST_CYCLE=false

        echo ""
        echo "✅ Cycle #$CYCLE_COUNT complete!"

        # Check if we should continue
        REMAINING=$(( (DURATION_SEC - ($(date +%s) - START_TIME)) / 60 ))
        if [[ "$REMAINING" -gt 0 ]]; then
            echo "⏱️  Time remaining: approx $REMAINING minutes"
            echo "⏸️  Waiting 10 seconds before next cycle..."
            sleep 10
        else
            echo "⏰  No time remaining, ending..."
            break
        fi
    done

    echo ""
    echo "🎉 GhostWriter session completed!"
    cleanup
}

# Main Loop
# Start the script
echo ""
echo "🎬 Starting GhostWriter..."
echo "   Duration: $DURATION_MINUTES minutes"
echo "   Source: $SOURCE_PATH"

# Get initial mouse position
INITIAL_MOUSE=$(get_mouse_pos)
echo "📍 Initial mouse position: $INITIAL_MOUSE"
echo ""

# Initialize editor (VS Code opens files individually with -r flag)
open_editor_workspace

# Run the main loop
main_loop
