#!/bin/bash

# Defaults
DURATION_MINUTES=30
MIN_DELAY_MS=100
MAX_DELAY_MS=300
SUBPROJECT_NAME="simulation-subproject"
SOURCE_FILE_RELATIVE="src/app/main/index.ts"

# Embedded Comprehensive Source (TypeScript)
read -r -d '' DEFAULT_CONTENT << 'EOF'
/**
 * Enterprise Grade Nothing-Doer
 * -------------------------------------------------------------------------
 * This file contains highly sophisticated logic for achieving absolutely nothing.
 * It is structured to simulate a complex enterprise application component.
 */

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
    echo "  --min-delay <ms>       Minimum delay between keystrokes (default: 100)"
    echo "  --max-delay <ms>       Maximum delay between keystrokes (default: 300)"
    echo "  --name <name>          Name of subproject (default: simulation-subproject)"
    echo "  --source <path>        Relative path to source file (default: src/app/main/index.ts)"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  ghost-writer --duration 60               # Run for 1 hour"
    echo "  ghost-writer --min-delay 50 --max-delay 150 # Type faster"
    echo "  ghost-writer --name my-project           # Custom subproject name"
    echo "  ghost-writer --source src/utils.ts       # Type a specific file"
    exit 0
}

# Argument Parsing
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--duration) DURATION_MINUTES="$2"; shift ;;
        --min-delay) MIN_DELAY_MS="$2"; shift ;;
        --max-delay) MAX_DELAY_MS="$2"; shift ;;
        --name) SUBPROJECT_NAME="$2"; shift ;;
        --source) SOURCE_FILE_RELATIVE="$2"; shift ;;
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

SOURCE_PATH="$ROOT_PATH/$SOURCE_FILE_RELATIVE"

# Fallback Source Detection
if [[ ! -f "$SOURCE_PATH" ]]; then
    # Try common alternatives if the default was not explicitly overridden (or even if it was, maybe warn?)
    # For now, let's just checking common paths if the specific one fails.
    if [[ -f "$ROOT_PATH/src/index.ts" ]]; then
        echo "Warning: '$SOURCE_FILE_RELATIVE' not found. Using 'src/index.ts' instead."
        SOURCE_PATH="$ROOT_PATH/src/index.ts"
    elif [[ -f "$ROOT_PATH/index.ts" ]]; then
        echo "Warning: '$SOURCE_FILE_RELATIVE' not found. Using 'index.ts' instead."
        SOURCE_PATH="$ROOT_PATH/index.ts"
    else
        echo "Warning: Default source file not found. Generating detailed test source..."
        ECHO_FILE="$ROOT_PATH/default_simulation_source.ts"
        echo "$DEFAULT_CONTENT" > "$ECHO_FILE"
        SOURCE_PATH="$ECHO_FILE"
        GENERATED_SOURCE=true
    fi
fi

SUBPROJECT_PATH="$ROOT_PATH/$SUBPROJECT_NAME"
TARGET_FILE="$SUBPROJECT_PATH/index.ts"

# Validating OS
OS_NAME=$(uname -s)
echo "Detected OS: $OS_NAME"

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
        # macOS
        if ! command -v osascript &> /dev/null; then
             echo "❌  Error: 'osascript' not found (this is unexpected on macOS)."
             exit 1
        fi
        echo "✅  'osascript' found."
    fi
}

check_dependencies

# Function to type text
function type_text {
    local text="$1"

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # macOS: Use AppleScript
        # We need to escape special characters for AppleScript string
        # This is tricky in bash. Using a simpler approach:
        # Create a temporary file with the text, read it in AppleScript loop?
        # Better: create a comprehensive AppleScript to handle the whole typing of a string

        # Escaping for AppleScript string:
        # \ -> \\
        # " -> \"
        local safe_text=$(echo "$text" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')

        # Execute and capture error
        if ! output=$(osascript -e "
            set textToType to \"$safe_text\"
            delay 0.05
            repeat with i from 1 to count of characters of textToType
                set char to character i of textToType
                tell application \"System Events\" to keystroke char
                delay (random number from ($MIN_DELAY_MS / 1000) to ($MAX_DELAY_MS / 1000))
            end repeat
            tell application \"System Events\" to key code 36 -- Enter
        " 2>&1); then
            if [[ "$output" == *"not allowed to send keystrokes"* ]]; then
                echo "❌  ERROR: macOS Permission Denied"
                echo "    Go to System Settings > Privacy & Security > Accessibility"
                echo "    Ensure your Terminal/Editor is CHECKED."
                exit 1
            else
                echo "Error typing: $output"
            fi
        fi
    elif [[ "$OS_NAME" == "Linux" ]]; then
        # Linux: Use xdotool
        # Simulating random delay per char in pure bash loop + xdotool is slow.
        # xdotool has --delay but it is fixed.
        # We will try to loop chars in bash.
        local len=${#text}
        for (( i=0; i<len; i++ )); do
            char="${text:$i:1}"
            xdotool type --delay 0 "$char"
            # sleep supports decimals? usually no in strict sh, yes in bash/coreutils
            # bash arithmetic $((...)) does integer only.
            # Using python or perl for random float sleep if needed, or just sleep 0.something
            # Simplified: random number between min/max ms.
            # integer random:
            local delay_ms=$(( MIN_DELAY_MS + RANDOM % (MAX_DELAY_MS - MIN_DELAY_MS + 1) ))
            local delay_sec=$(awk "BEGIN {print $delay_ms/1000}")
            sleep "$delay_sec"
        done
        xdotool key Return
    else
        # Windows (Git Bash/WSL/Cygwin)
        # We use PowerShell's SendKeys to simulate typing.
        # Note: ' needs to be escaped for PowerShell.

        # Escape single quotes for PowerShell string: ' -> ''
        local ps_text="${text//\'/\'\'}"
        # Escape double quotes: " -> \"
        ps_text="${ps_text//\"/\\\"}"

        # PowerShell command to send keys
        # We use a simple sleep for delay (not per-character random in this simple version,
        # but we can do a loop in PS if needed. For simplicity/speed in PS startup,
        # we'll just send the whole line or chunks).
        # Actually, SendKeys is instant. To mimic typing, we need a loop in PS.

        powershell.exe -Command "
            Add-Type -AssemblyName System.Windows.Forms
            \$text = '$ps_text'
            foreach (\$char in \$text.ToCharArray()) {
                [System.Windows.Forms.SendKeys]::SendWait(\$char)
                Start-Sleep -Milliseconds $(($MIN_DELAY_MS + ($RANDOM % ($MAX_DELAY_MS - $MIN_DELAY_MS + 1))))
            }
            [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
        " > /dev/null 2>&1
    fi
}

# Mouse Position Helper
function get_mouse_pos {
    if [[ "$OS_NAME" == "Darwin" ]]; then
        # macOS: Use Python ctypes to get mouse location from CoreGraphics
        python3 -c "
import ctypes
import ctypes.util

# Load CoreGraphics framework
cg_path = ctypes.util.find_library('CoreGraphics')
if not cg_path:
    # Fallback for some systems? Usually standard.
    print('0,0')
    exit()

cg = ctypes.cdll.LoadLibrary(cg_path)

# Define types
class CGPoint(ctypes.Structure):
    _fields_ = [('x', ctypes.c_double), ('y', ctypes.c_double)]

# CGEventCreate(source) -> event
cg.CGEventCreate.restype = ctypes.c_void_p
cg.CGEventCreate.argtypes = [ctypes.c_void_p]

# CGEventGetLocation(event) -> CGPoint
cg.CGEventGetLocation.restype = CGPoint
cg.CGEventGetLocation.argtypes = [ctypes.c_void_p]

# Create event (NULL source) and get location
event = cg.CGEventCreate(None)
loc = cg.CGEventGetLocation(event)
print(f'{int(loc.x)},{int(loc.y)}')
" 2>/dev/null || echo "0,0"

    elif [[ "$OS_NAME" == "Linux" ]]; then
        # output: x: 123 y: 456 screen: 0 window: 12345
        xdotool getmouselocation --shell 2>/dev/null | grep -E "X=|Y=" | tr '\n' ',' | sed 's/X=//;s/Y=//;s/,$//'
        # result: 123,456
    else
        # Windows PowerShell
        powershell.exe -Command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; \$pos = [System.Windows.Forms.Cursor]::Position; Write-Host \"\$(\$pos.X),\$(\$pos.Y)\"" 2>/dev/null | tr -d '\r'
    fi
}

function monitor_mouse {
    local initial_pos="$1"
    local main_pid="$2"

    echo "Using initial mouse position: $initial_pos" >> /dev/null

    while kill -0 "$main_pid" 2>/dev/null; do
        current_pos=$(get_mouse_pos)

        # Check if valid (not empty/error)
        if [[ -n "$current_pos" && "$current_pos" != "0,0" && "$current_pos" != "$initial_pos" ]]; then
            echo ""
            echo "🛑  Mouse movement detected! Terminating simulation for user control."
            kill -INT "$main_pid" 2>/dev/null
            break
        fi
        sleep 0.5
    done
}

# Active Application Helper
function get_active_app {
    if [[ "$OS_NAME" == "Darwin" ]]; then
        osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        # Try finding window class name
        id=$(xdotool getactivewindow 2>/dev/null)
        if [[ -n "$id" ]]; then
            xdotool getwindowclassname "$id" 2>/dev/null
        fi
    else
        # Windows handling (Generic fallback for now to avoid blocking)
        echo "Windows_Generic"
    fi
}

function is_safe_app {
    local app_name="$1"
    # Whitelist
    case "$app_name" in
        *Code*|*VSCode*|*Antigravity*|*Kersa*|*Windsurf*|*TextEdit*|*Notepad*|*gedit*|*kate*|*iTerm*|*Warp*|*Alacritty*|*Hyper*|*kitty*|*Windows_Generic*)
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
        osascript -e "tell application \"$app_name\" to activate" 2>/dev/null
    elif [[ "$OS_NAME" == "Linux" ]]; then
        # Search for window by class name or name and activate
        xdotool search --name "$app_name" windowactivate 2>/dev/null || xdotool search --class "$app_name" windowactivate 2>/dev/null
    else
        # Windows: Creating a thorough focus switcher in one-line PS is hard, but we can try AppActivate
        # Note: AppActivate works by Title, not process name usually.
        powershell.exe -Command "(New-Object -ComObject WScript.Shell).AppActivate('$app_name')" 2>/dev/null
    fi
}

function wait_for_safe_focus {
    local last_log=""

    # Check current app
    local current_app=$(get_active_app)

    # If currently safe, update our "Known Good Editor" tracker
    if is_safe_app "$current_app"; then
        KNOWN_EDITOR_APP="$current_app"
        return 0
    fi

    # If we are NOT in a safe app, but we knew one previously, TRY TO REFOCUS IT
    if [[ -n "$KNOWN_EDITOR_APP" ]]; then
         echo -ne "\r🔄  Lost focus to '$current_app'. Refocusing '$KNOWN_EDITOR_APP'...   "
         refocus_app "$KNOWN_EDITOR_APP"
         sleep 0.5

         # Check if it worked
         current_app=$(get_active_app)
         if is_safe_app "$current_app"; then
             # Clear line and return
             echo -ne "\r                                                                           \r"
             return 0
         fi
    fi

    # Fallback: Loop and wait if refocus failed or no known editor yet
    while true; do
        current_app=$(get_active_app)
        if is_safe_app "$current_app"; then
            KNOWN_EDITOR_APP="$current_app"
            break
        fi

        # Log only if the app has changed to avoid spamming
        if [[ "$current_app" != "$last_log" ]]; then
             echo ""
             echo "🚫  [LOG] Unsupported App Detected: '$current_app'"
             last_log="$current_app"
        fi

        echo -ne "\r⏳  Paused. Waiting for safe app...   "
        sleep 1
    done
    # Clear line if we waited
    echo -ne "\r                                                                           \r"
}

# Main Loop
while true; do
    CURRENT_TIME=$(date +%s)
    ELAPSED=$((CURRENT_TIME - START_TIME))
    if [[ "$ELAPSED" -ge "$DURATION_SEC" ]]; then
        echo "Duration reached. Exiting."
        break
    fi
    echo ""
    echo "--- Starting new cycle ---"

    # Setup Subproject
    # Aggressive cleanup
    if [[ -d "$SUBPROJECT_PATH" ]]; then
        rm -rf "$SUBPROJECT_PATH"
    fi
    mkdir -p "$SUBPROJECT_PATH"

    # Extract extension from source file to maintain language highlights
    # If source path has no extension, default to .txt or keep empty
    filename=$(basename "$SOURCE_PATH")
    extension="${filename##*.}"

    # Handle case where file has no extension
    if [[ "$filename" == "$extension" ]]; then
        extension="txt"
    fi

    # Generate unique filename to bypass editor buffer caching/auto-save
    # This ensures a fresh tab/buffer is always used.
    TARGET_FILE="$SUBPROJECT_PATH/index_$(date +%s).$extension"
    touch "$TARGET_FILE"

    echo "Opening $TARGET_FILE ..."
    # Open Editor (Cross platform)
    if [[ "$OS_NAME" == "Darwin" ]]; then
        open "$TARGET_FILE"
    elif [[ "$OS_NAME" == "Linux" ]]; then
        xdg-open "$TARGET_FILE" || code "$TARGET_FILE" || nano "$TARGET_FILE"
    else
        start "$TARGET_FILE" 2>/dev/null || echo "Please open file manually: $TARGET_FILE"
    fi

    # Countdown
    echo ""
    echo "⚠️  PLEASE FOCUS THE TEXT EDITOR WINDOW NOW! (5 seconds warning) ⚠️"
    for i in {5..1}; do
        echo -n "$i... "
        sleep 1
    done
    echo ""
    echo "Starting typing simulation..."

    # Capture initial mouse position for monitoring
    INITIAL_MOUSE_POS=$(get_mouse_pos)
    # Start monitoring in background
    monitor_mouse "$INITIAL_MOUSE_POS" "$$" &
    MONITOR_PID=$!

    # Read file line by line
    # IFS= prevents trimming leading/trailing whitespace
    while IFS= read -r line || [[ -n "$line" ]]; do

        # Random "Thinking" Pause (Realism)
        # 5% chance (approx 1 in 20 lines) to pause for 30s+
        if (( RANDOM % 20 == 0 )); then
            pause_duration=$(( 30 + RANDOM % 31 )) # 30 to 60 seconds
            echo ""
            echo "🧠  Thinking/Pause for ${pause_duration}s... (User can take control)"
            sleep "$pause_duration"
            echo "▶️  Resuming typing..."
        fi

        # Safety Check: Pause if user switched away to a browser/slack
        # User requested to disable app detection ("Just type where the Kesa is")
        # wait_for_safe_focus

        # Trim leading whitespace to avoid "stair-stepping" (double indentation)
        # caused by editor auto-indent + script typing spaces.
        trimmed_line="${line#"${line%%[![:space:]]*}"}"

        echo "Typing: ${trimmed_line:0:20}..."
        type_text "$trimmed_line"
        sleep 0.5

        # Check loop exit condition inside inner loop to be responsive?
        # Or finish the file. Let's finish the file.
    done < "$SOURCE_PATH"

    echo "Finished typing file. Waiting before restart..."
    sleep 2

    REMAINING=$(( (DURATION_SEC - (date +%s - START_TIME)) / 60 ))
    echo "Time remaining: approx $REMAINING minutes."
done
