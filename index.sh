#!/bin/bash

# Defaults
DURATION_MINUTES=30
MIN_DELAY_MS=150
MAX_DELAY_MS=380
SUBPROJECT_NAME="simulation-subproject"
SOURCE_FILE_RELATIVE=""
MOUSE_MONITOR_ACTIVE=false

# Human-behavior simulation
TERMINAL_APP="Warp Preview"   # terminal that hosts the vim window
SLACK_APP="Slack"             # Slack desktop app name
ENABLE_BROWSER=true           # open the default browser and "research" topics
ENABLE_SLACK=true             # open Slack and draft (never send) a message
BREAK_CHANCE=45               # % chance of stepping away between files

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
    echo "  -d, --duration <min>   Duration in minutes (default: 30)"
    echo "  --min-delay <ms>       Minimum delay between keystrokes (default: 150)"
    echo "  --max-delay <ms>       Maximum delay between keystrokes (default: 380)"
    echo "  --name <name>          Name of subproject (default: simulation-subproject)"
    echo "  --source <path>        Relative or absolute path to source file/directory"
    echo "  --terminal-app <name>  Terminal app to host vim (default: 'Warp Preview')"
    echo "  --slack-app <name>     Slack app name (default: 'Slack')"
    echo "  --no-browser           Disable browser 'research' breaks"
    echo "  --no-slack             Disable Slack breaks"
    echo "  --break-chance <0-100> Chance of stepping away between files (default: 45)"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  ghost-writer --duration 60               # Run for 1 hour with default source"
    echo "  ghost-writer --min-delay 50 --max-delay 150 # Type faster"
    echo "  ghost-writer --name my-project           # Custom subproject name"
    echo "  ghost-writer --source src/utils.ts       # Type a specific file"
    echo "  ghost-writer --source src/               # Process all files in directory"
    echo "  ghost-writer --no-slack --no-browser     # Pure typing, no distractions"
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
        --terminal-app) TERMINAL_APP="$2"; shift ;;
        --slack-app) SLACK_APP="$2"; shift ;;
        --no-browser) ENABLE_BROWSER=false ;;
        --no-slack) ENABLE_SLACK=false ;;
        --break-chance) BREAK_CHANCE="$2"; shift ;;
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

    # Vim Requirement (All Platforms)
    if ! command -v vim &> /dev/null; then
        echo "❌  Error: 'vim' editor not found."
        echo "    Please install vim:"
        if [[ "$OS_NAME" == "Darwin" ]]; then
            echo "    brew install vim"
        elif [[ "$OS_NAME" == "Linux" ]]; then
            echo "    sudo apt-get install vim  (or equivalent for your distro)"
        fi
        exit 1
    fi
    echo "✅  'vim' found."
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
    # No source specified - try defaults first, then use embedded content
    SOURCE_PATH=""
    FOUND_DEFAULT=false

    # Try default paths
    if [[ -f "$ROOT_PATH/src/app/main/index.ts" ]]; then
         SOURCE_PATH="$ROOT_PATH/src/app/main/index.ts"
         FOUND_DEFAULT=true
    elif [[ -f "$ROOT_PATH/src/index.ts" ]]; then
         SOURCE_PATH="$ROOT_PATH/src/index.ts"
         FOUND_DEFAULT=true
    elif [[ -f "$ROOT_PATH/index.ts" ]]; then
         SOURCE_PATH="$ROOT_PATH/index.ts"
         FOUND_DEFAULT=true
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

# Function to save the current file in Vim
function save_file {
    echo "💾 Saving file (:w)..."

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # macOS: Escape to normal mode, then :w to save
        osascript -e 'tell application "System Events" to key code 53' 2>/dev/null  # Escape
        sleep 0.2
        osascript -e 'tell application "System Events" to keystroke ":w"' 2>/dev/null
        sleep 0.1
        osascript -e 'tell application "System Events" to key code 36' 2>/dev/null  # Enter
    elif [[ "$OS_NAME" == "Linux" ]]; then
        # Linux: Escape, :w, Enter
        xdotool key Escape
        sleep 0.2
        xdotool type ":w"
        sleep 0.1
        xdotool key Return
    else
        # Windows: Escape, :w, Enter
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.SendKeys]::SendWait('{ESC}')
            Start-Sleep -Milliseconds 200
            [System.Windows.Forms.SendKeys]::SendWait(':w')
            Start-Sleep -Milliseconds 100
            [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
        " > /dev/null 2>&1
    fi

    sleep 0.3

    # Return to Insert mode for continued typing
    if [[ "$OS_NAME" == "Darwin" ]]; then
        osascript -e 'tell application "System Events" to keystroke "i"' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool type "i"
    else
        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.SendKeys]::SendWait('i')
        " > /dev/null 2>&1
    fi
    sleep 0.2
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


# Function to type text character by character
function type_text {
    local text="$1"
    local len=${#text}

    # Type character by character
    for (( i=0; i<len; i++ )); do
        local char="${text:$i:1}"
        type_char "$char"
        # Random delay between keystrokes
        local delay_ms=$(( MIN_DELAY_MS + RANDOM % (MAX_DELAY_MS - MIN_DELAY_MS + 1) ))
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
        *TextEdit*|*Notepad*|*gedit*|*kate*|*vim*|*nvim*|*emacs*|*iTerm*|*Terminal*|*Warp*|*Alacritty*|*Hyper*|*kitty*|*Windows_Generic*)
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
        # For macOS, bring the terminal hosting vim back to the front
        osascript -e "tell application \"$TERMINAL_APP\" to activate" 2>/dev/null || \
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

# ── Human-behavior helpers: browsing, Slack, and natural breaks ──────────

# URL-encode a string for use in a search query
function urlencode {
    local s="$1"
    if command -v python3 &>/dev/null; then
        python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$s" 2>/dev/null && return
    fi
    echo "${s// /+}"
}

# Open a URL in the default browser without moving focus away from the keyboard
function open_url {
    local url="$1"
    if [[ "$OS_NAME" == "Darwin" ]]; then
        open "$url" 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdg-open "$url" 2>/dev/null &
    else
        powershell.exe -Command "Start-Process '$url'" > /dev/null 2>&1
    fi
}

# ── Timing guards so long pauses never overrun the session duration ──────

function seconds_left { echo $(( DURATION_SEC - ($(date +%s) - START_TIME) )); }

function time_up { [[ "$(seconds_left)" -le 0 ]]; }

# Sleep up to N seconds, but never past the deadline. Returns 1 when time is up.
function capped_sleep {
    local want="$1"
    local left
    left="$(seconds_left)"
    (( left <= 0 )) && return 1
    (( want > left )) && want="$left"
    (( want > 0 )) && sleep "$want"
    return 0
}

# ── Low-level keystroke helpers (used to drive vim across files) ──────────

function press_escape {
    if [[ "$OS_NAME" == "Darwin" ]]; then
        osascript -e 'tell application "System Events" to key code 53' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool key Escape
    else
        powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ESC}')" > /dev/null 2>&1
    fi
}

function press_enter {
    if [[ "$OS_NAME" == "Darwin" ]]; then
        osascript -e 'tell application "System Events" to key code 36' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool key Return
    else
        powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')" > /dev/null 2>&1
    fi
}

# Type a short control string instantly (vim commands like :b2, :w, G, A)
function send_keys_instant {
    local s="$1"
    if [[ "$OS_NAME" == "Darwin" ]]; then
        osascript -e "tell application \"System Events\" to keystroke \"$s\"" 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdotool type --delay 0 -- "$s"
    else
        local esc="${s//\'/\'\'}"
        powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('$esc')" > /dev/null 2>&1
    fi
}

# Switch the single vim window to buffer N (each file is a numbered buffer)
function vim_switch_buffer {
    press_escape; sleep 0.15
    send_keys_instant ":b$1"; sleep 0.1
    press_enter; sleep 0.35
}

# Move to end of the current buffer and enter insert mode to append
function vim_resume_append {
    press_escape; sleep 0.1
    send_keys_instant "G"; sleep 0.1
    send_keys_instant "A"; sleep 0.2
}

# Save the current buffer (stays in normal mode afterwards)
function vim_save {
    press_escape; sleep 0.15
    send_keys_instant ":w"; sleep 0.1
    press_enter; sleep 0.25
}

# Build search queries derived from the language and identifiers of a source file
function derive_search_queries {
    local file="$1"
    local ext="${file##*.}"
    local lang
    case "$ext" in
        ts|tsx) lang="typescript" ;;
        js|jsx) lang="javascript" ;;
        py)     lang="python" ;;
        go)     lang="golang" ;;
        rs)     lang="rust" ;;
        java)   lang="java" ;;
        rb)     lang="ruby" ;;
        sh)     lang="bash" ;;
        c|h)    lang="c" ;;
        cpp|cc|hpp) lang="c++" ;;
        *)      lang="programming" ;;
    esac

    local -a symbols=()
    if [[ -f "$file" ]]; then
        while IFS= read -r name; do
            [[ -n "$name" ]] && symbols+=("$name")
        done < <(grep -oE '\b(class|interface|function|type|struct|def|func)[[:space:]]+[A-Za-z_][A-Za-z0-9_]*' "$file" 2>/dev/null \
                    | awk '{print $2}' | sort -u | head -n 5)
    fi

    local -a topics=(
        "best practices" "design patterns" "error handling"
        "async await" "unit testing" "performance optimization"
        "clean code" "dependency injection" "memory management"
    )

    local -a queries=()
    queries+=("$lang ${topics[RANDOM % ${#topics[@]}]}")
    if [[ ${#symbols[@]} -gt 0 ]]; then
        local sym="${symbols[RANDOM % ${#symbols[@]}]}"
        queries+=("$lang $sym implementation")
        queries+=("how to test $sym in $lang")
    fi
    queries+=("stack overflow $lang ${topics[RANDOM % ${#topics[@]}]}")

    printf '%s\n' "${queries[@]}"
}

# Step away to "research" a couple of project-related topics in the browser
function browser_research {
    [[ "$ENABLE_BROWSER" != "true" ]] && return 0
    local file="$1"

    echo "🌐 Taking a break to look something up..."

    local -a queries=()
    while IFS= read -r q; do queries+=("$q"); done < <(derive_search_queries "$file")
    [[ ${#queries[@]} -eq 0 ]] && return 0

    local count=$(( 1 + RANDOM % 2 ))  # 1-2 searches
    for (( n=0; n<count && n<${#queries[@]}; n++ )); do
        local query="${queries[n]}"
        echo "   🔎 Searching: \"$query\""
        open_url "https://www.google.com/search?q=$(urlencode "$query")"
        local read_time=$(( 6 + RANDOM % 15 ))
        echo "   📖 Reading for ${read_time}s..."
        capped_sleep "$read_time" || break
    done

    echo "   ↩️  Back to the code."
    refocus_app "$KNOWN_EDITOR_APP"
    sleep 1
}

# Open Slack, linger, open a random member's DM and draft a message — never sent
function slack_interlude {
    [[ "$ENABLE_SLACK" != "true" ]] && return 0

    if [[ "$OS_NAME" != "Darwin" ]]; then
        return 0
    fi

    echo "💬 Checking Slack..."
    open -a "$SLACK_APP" 2>/dev/null
    osascript -e "tell application \"$SLACK_APP\" to activate" 2>/dev/null
    sleep 1.5

    local linger=$(( 8 + RANDOM % 15 ))
    echo "   👀 Reading messages for ${linger}s..."
    capped_sleep "$linger" || { refocus_app "$KNOWN_EDITOR_APP"; return 0; }

    echo "   🧭 Opening a direct message..."
    osascript -e 'tell application "System Events" to keystroke "k" using command down' 2>/dev/null
    sleep 1

    # Surface people with a random letter, step down to a random result, open it
    local letters=(a b c d e j m s t)
    local letter="${letters[RANDOM % ${#letters[@]}]}"
    osascript -e "tell application \"System Events\" to keystroke \"$letter\"" 2>/dev/null
    sleep 1
    local steps=$(( RANDOM % 4 ))
    for (( s=0; s<steps; s++ )); do
        osascript -e 'tell application "System Events" to key code 125' 2>/dev/null  # Down
        sleep 0.3
    done
    # Enter here only navigates to the conversation (composer is empty — nothing is sent)
    osascript -e 'tell application "System Events" to key code 36' 2>/dev/null
    sleep 1.5

    local drafts=(
        "hey, quick question when you get a sec"
        "morning! did you get a chance to look at the PR"
        "can you review this when you're free"
        "thanks for the help earlier"
    )
    local draft="${drafts[RANDOM % ${#drafts[@]}]}"
    echo "   ⌨️  Drafting (never sent): \"$draft\""
    osascript -e "tell application \"System Events\" to keystroke \"$draft\"" 2>/dev/null
    sleep 2

    # Clear the draft so nothing is left in the composer; Enter is never pressed
    osascript -e 'tell application "System Events" to keystroke "a" using command down' 2>/dev/null
    sleep 0.2
    osascript -e 'tell application "System Events" to key code 51' 2>/dev/null  # Delete
    sleep 1

    echo "   💬 Leaving Slack open, back to work."
    refocus_app "$KNOWN_EDITOR_APP"
    sleep 1
}

# Between files, sometimes behave like a distracted human: browse, Slack, or rest
function maybe_take_break {
    local file="$1"
    local roll=$(( RANDOM % 100 ))

    if (( roll >= BREAK_CHANCE )); then
        return 0  # stay heads-down
    fi

    local pick=$(( RANDOM % 100 ))
    if (( pick < 45 )); then
        browser_research "$file"
    elif (( pick < 80 )); then
        slack_interlude
    else
        local nap=$(( 10 + RANDOM % 20 ))
        echo "☕ Stepping away for ${nap}s..."
        capped_sleep "$nap"
    fi
}

# Cleanup handler for graceful shutdown
function cleanup {
    echo ""
    echo "🧹 Cleaning up..."
    if [[ -n "$MOUSE_MONITOR_PID" ]] && kill -0 "$MOUSE_MONITOR_PID" 2>/dev/null; then
        kill "$MOUSE_MONITOR_PID" 2>/dev/null
        wait "$MOUSE_MONITOR_PID" 2>/dev/null
    fi
    MOUSE_MONITOR_ACTIVE=false
    exit 0
}

trap cleanup SIGINT SIGTERM

# All files open together as buffers in one vim window
function open_editor_workspace {
    echo "📂 Ready to open files in vim..."
    echo "   (All files open together in a new $TERMINAL_APP window)"
}


# Open every source file as a numbered buffer in ONE vim window
function open_all_in_vim {
    # Uses globals: TARGETS (array), TERMINAL_APP, OS_NAME
    local vim_cmd="vim"
    local t
    for t in "${TARGETS[@]}"; do
        vim_cmd+=" '$t'"
    done

    echo "📂 Opening ${#TARGETS[@]} file(s) in a single vim window..."

    if [[ "$OS_NAME" == "Darwin" ]]; then
        osascript -e "tell application \"$TERMINAL_APP\" to activate" 2>/dev/null
        sleep 0.8
        osascript -e 'tell application "System Events" to keystroke "n" using command down' 2>/dev/null
        sleep 1.4
        send_keys_instant "$vim_cmd"
        press_enter
        sleep 1.2
    elif [[ "$OS_NAME" == "Linux" ]]; then
        if command -v gnome-terminal &> /dev/null; then
            gnome-terminal --maximize -- vim "${TARGETS[@]}" &
        elif command -v xterm &> /dev/null; then
            xterm -maximized -e vim "${TARGETS[@]}" &
        else
            echo "⚠️  Please open vim manually: $vim_cmd"
        fi
        sleep 2
    else
        start /max bash -c "$vim_cmd" 2>/dev/null || echo "Please open vim manually: $vim_cmd"
        sleep 2
    fi
}

# Type the whole batch by hopping between files a line or two at a time,
# the way a developer actually moves around a codebase.
function run_typing_cycle {
    # Uses global: SRC_FILES (array of source paths)
    local n=${#SRC_FILES[@]}
    (( n == 0 )) && return 1

    local -a TARGETS NEXT TOTAL DONE
    local i
    for (( i=0; i<n; i++ )); do
        local fn
        fn=$(basename "${SRC_FILES[i]}")
        TARGETS[i]="$SUBPROJECT_PATH/$(date +%s)_${RANDOM}_${fn}"
        : > "${TARGETS[i]}"
        NEXT[i]=1
        TOTAL[i]=$(awk 'END{print NR}' "${SRC_FILES[i]}" 2>/dev/null)
        [[ -z "${TOTAL[i]}" ]] && TOTAL[i]=0
        DONE[i]=0
        (( TOTAL[i] == 0 )) && DONE[i]=1
    done

    open_all_in_vim

    echo "⏳ Focusing the editor (5s)..."
    sleep 5
    wait_for_safe_focus

    if [[ "$MOUSE_MONITOR_ACTIVE" == "false" ]]; then
        local initial_mouse
        initial_mouse=$(get_mouse_pos)
        monitor_mouse "$initial_mouse" "$$" &
        MOUSE_MONITOR_PID=$!
        MOUSE_MONITOR_ACTIVE=true
    fi

    local remaining=$n
    local typed_anything=0
    local switches=0

    while (( remaining > 0 )); do
        time_up && { echo "⏰  Duration reached mid-cycle."; break; }

        for (( i=0; i<n; i++ )); do
            (( DONE[i] == 1 )) && continue
            time_up && break
            kill -0 $$ 2>/dev/null || return 1

            wait_for_safe_focus
            vim_switch_buffer "$(( i + 1 ))"
            vim_resume_append

            # Type a burst of 1–2 lines, then move on
            local burst=$(( 1 + RANDOM % 2 ))
            local c
            for (( c=0; c<burst; c++ )); do
                (( NEXT[i] > TOTAL[i] )) && break
                local line
                line=$(sed -n "${NEXT[i]}p" "${SRC_FILES[i]}")
                wait_for_safe_focus
                type_text "$line"
                NEXT[i]=$(( NEXT[i] + 1 ))
                typed_anything=1
            done

            vim_save

            if (( NEXT[i] > TOTAL[i] )); then
                DONE[i]=1
                remaining=$(( remaining - 1 ))
                echo "✅ Finished $(basename "${SRC_FILES[i]}") (${TOTAL[i]} lines)"
            else
                echo "✍️  $(basename "${SRC_FILES[i]}"): $(( NEXT[i] - 1 ))/${TOTAL[i]} lines"
            fi

            # A short beat before hopping to the next file
            capped_sleep "$(( 1 + RANDOM % 3 ))" || break

            # Occasional longer "thinking" pause
            if (( RANDOM % 6 == 0 )); then
                local think=$(( 4 + RANDOM % 10 ))
                echo "🧠  Thinking for ${think}s..."
                capped_sleep "$think" || break
            fi

            # Every few file hops, maybe step away (browser / Slack / rest)
            switches=$(( switches + 1 ))
            if (( switches % 3 == 0 )) && ! time_up; then
                maybe_take_break "${SRC_FILES[i]}"
            fi
        done
    done

    echo "💾 Saving all files..."
    press_escape; sleep 0.15
    send_keys_instant ":wa"; sleep 0.1
    press_enter; sleep 0.3

    time_up && return 0
    (( typed_anything == 1 )) && return 0
    return 1
}

# Main Loop - Process cycles
function main_loop {
    local FIRST_CYCLE=true
    local CYCLE_COUNT=0

    while true; do
        if time_up; then
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

        local successfully_typed=false

        # Type the whole batch, hopping between files a line or two at a time
        SRC_FILES=("${FILES_TO_PROCESS[@]}")
        if run_typing_cycle; then
            successfully_typed=true
        fi

        # Only continue cycling if typing was successful
        if [[ "$successfully_typed" == "false" ]]; then
            echo ""
            echo "❌ ERROR: No files were successfully typed in this cycle!"
            echo "❌ This usually means:"
            echo "   1. The typing function encountered an error"
            echo "   2. Vim/Terminal is not properly focused"
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
        if ! time_up; then
            REMAINING=$(( $(seconds_left) / 60 ))
            echo "⏱️  Time remaining: approx $REMAINING minutes"
            echo "⏸️  Waiting before next cycle..."
            capped_sleep 10
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

# Announce the editor workflow before the first cycle
open_editor_workspace

# Run the main loop
main_loop
