#!/bin/bash
# Disk Space Cleanup Script
# Frees disk space used by Claude Code, Python caches, npm, and other dev tools
# No sudo permissions required

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}   Disk Space Cleanup Script${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Function to get folder size in bytes (for calculations)
get_size_bytes() {
    if [ -d "$1" ] || [ -f "$1" ]; then
        du -sk "$1" 2>/dev/null | cut -f1
    else
        echo "0"
    fi
}

# Function to get folder size (human readable)
get_size() {
    if [ -d "$1" ] || [ -f "$1" ]; then
        du -sh "$1" 2>/dev/null | cut -f1
    else
        echo "0B"
    fi
}

# Function to format bytes to human readable
format_bytes() {
    local bytes=$1
    if [ "$bytes" -ge 1048576 ]; then
        echo "$(echo "scale=1; $bytes/1048576" | bc)G"
    elif [ "$bytes" -ge 1024 ]; then
        echo "$(echo "scale=1; $bytes/1024" | bc)M"
    else
        echo "${bytes}K"
    fi
}

# Function to ask for confirmation
confirm() {
    local prompt="$1"
    local response
    echo -e -n "${YELLOW}$prompt [y/N]: ${NC}"
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

# Track total space freed (in KB)
total_freed=0

# Arrays to hold scan results
declare -a ITEM_NAMES
declare -a ITEM_PATHS
declare -a ITEM_SIZES
declare -a ITEM_SIZES_HR
declare -a ITEM_NOTES
declare -a ITEM_WARNINGS
declare -a ITEM_CMDS

# Function to add item to scan list
add_item() {
    local name="$1"
    local path="$2"
    local note="$3"
    local warning="$4"
    local cmd="$5"  # optional custom command

    if [ -d "$path" ]; then
        local size_kb=$(get_size_bytes "$path")
        if [ "$size_kb" -gt 0 ]; then
            ITEM_NAMES+=("$name")
            ITEM_PATHS+=("$path")
            ITEM_SIZES+=("$size_kb")
            ITEM_SIZES_HR+=("$(get_size "$path")")
            ITEM_NOTES+=("$note")
            ITEM_WARNINGS+=("$warning")
            ITEM_CMDS+=("$cmd")
        fi
    fi
}

echo -e "${BLUE}Scanning for cleanable items...${NC}"
echo ""

# =============================================================================
# PYTHON CACHES (Usually the biggest offenders)
# =============================================================================
add_item "pip cache" \
    "$HOME/Library/Caches/pip" \
    "Python package downloads - rebuilds automatically when needed" \
    "" \
    "pip cache purge 2>/dev/null; rm -rf '$HOME/Library/Caches/pip'"

add_item "pip-tools cache" \
    "$HOME/Library/Caches/pip-tools" \
    "pip-tools compilation cache - rebuilds automatically" \
    "" \
    ""

add_item "pypoetry cache" \
    "$HOME/Library/Caches/pypoetry" \
    "Poetry package cache - rebuilds when installing packages" \
    "" \
    ""

add_item "uv cache" \
    "$HOME/Library/Caches/uv" \
    "uv package manager cache - rebuilds automatically" \
    "" \
    ""

# =============================================================================
# DEV TOOL CACHES
# =============================================================================
add_item "Homebrew cache" \
    "$HOME/Library/Caches/Homebrew" \
    "Downloaded brew packages - run 'brew cleanup' to rebuild" \
    "" \
    "brew cleanup --prune=all 2>/dev/null; rm -rf '$HOME/Library/Caches/Homebrew'"

add_item "npm cache" \
    "$HOME/.npm" \
    "Node package cache - rebuilds when installing packages" \
    "" \
    "npm cache clean --force 2>/dev/null"

add_item "pnpm cache" \
    "$HOME/Library/Caches/pnpm" \
    "pnpm package cache - rebuilds automatically" \
    "" \
    ""

add_item "yarn cache" \
    "$HOME/Library/Caches/Yarn" \
    "Yarn package cache - rebuilds automatically" \
    "" \
    ""

add_item "go build cache" \
    "$HOME/Library/Caches/go-build" \
    "Go compilation cache - rebuilds automatically" \
    "" \
    ""

add_item "Rust cargo cache" \
    "$HOME/.cargo/registry/cache" \
    "Rust crate cache - rebuilds automatically" \
    "" \
    ""

# =============================================================================
# SECURITY TOOL CACHES
# =============================================================================
add_item "grype cache" \
    "$HOME/Library/Caches/grype" \
    "Vulnerability database cache - re-downloads on next scan" \
    "" \
    ""

add_item "trivy cache" \
    "$HOME/Library/Caches/trivy" \
    "Vulnerability database cache - re-downloads on next scan" \
    "" \
    ""

# =============================================================================
# DOCKER (if running)
# =============================================================================
DOCKER_RECLAIMABLE=""
if command -v docker &> /dev/null && docker info &> /dev/null; then
    DOCKER_SIZE=$(docker system df --format '{{.Reclaimable}}' 2>/dev/null | head -1)
    if [ -n "$DOCKER_SIZE" ] && [ "$DOCKER_SIZE" != "0B" ]; then
        # Add a pseudo-entry for Docker
        ITEM_NAMES+=("Docker (unused images/containers/volumes)")
        ITEM_PATHS+=("__DOCKER__")
        # Estimate size from docker system df
        DOCKER_TOTAL=$(docker system df --format '{{.Size}}' 2>/dev/null | awk '{sum+=$1} END {print sum}')
        ITEM_SIZES+=("0")
        ITEM_SIZES_HR+=("$DOCKER_SIZE reclaimable")
        ITEM_NOTES+=("Unused Docker resources - keeps active containers")
        ITEM_WARNINGS+=("")
        ITEM_CMDS+=("docker system prune -af --volumes")
    fi
fi

# =============================================================================
# BROWSER CACHES (optional, larger impact on UX)
# =============================================================================
add_item "Firefox cache" \
    "$HOME/Library/Caches/Firefox" \
    "Browser cache - pages may load slower until rebuilt" \
    "Browser will re-download cached content" \
    ""

add_item "Chrome cache" \
    "$HOME/Library/Caches/Google/Chrome" \
    "Browser cache - pages may load slower until rebuilt" \
    "Browser will re-download cached content" \
    ""

# =============================================================================
# CLAUDE CODE SPECIFIC
# =============================================================================
add_item "Claude CLI cache" \
    "$HOME/Library/Caches/claude-cli-nodejs" \
    "Claude Code cache - rebuilds automatically" \
    "" \
    ""

add_item "Claude debug logs" \
    "$HOME/.claude/debug" \
    "Debug information - safe to delete" \
    "" \
    ""

add_item "Claude shell snapshots" \
    "$HOME/.claude/shell-snapshots" \
    "Terminal state snapshots - safe to delete" \
    "" \
    ""

add_item "Claude file history" \
    "$HOME/.claude/file-history" \
    "Undo history for file edits" \
    "You lose ability to undo past Claude edits" \
    ""

add_item "Claude project conversations" \
    "$HOME/.claude/projects" \
    "Conversation history for projects" \
    "Deletes all conversation history" \
    ""

add_item "Claude todos" \
    "$HOME/.claude/todos" \
    "Saved todo lists" \
    "Deletes all saved todos" \
    ""

# =============================================================================
# DISPLAY SUMMARY
# =============================================================================
echo -e "${BOLD}${CYAN}=== SCAN RESULTS ===${NC}"
echo ""

# Calculate total
total_scannable=0
for size in "${ITEM_SIZES[@]}"; do
    total_scannable=$((total_scannable + size))
done

# Show current disk status
DISK_AVAIL=$(df -h / | awk 'NR==2 {print $4}')
DISK_USED=$(df -h / | awk 'NR==2 {print $5}')
echo -e "${BOLD}Current disk:${NC} ${DISK_USED} used, ${DISK_AVAIL} available"
echo -e "${BOLD}Cleanable:${NC} $(format_bytes $total_scannable) found across ${#ITEM_NAMES[@]} items"
echo ""

# Display items grouped by size
echo -e "${BOLD}Items found (sorted by size):${NC}"
echo ""

# Create sorted indices by size (descending)
indices=($(for i in "${!ITEM_SIZES[@]}"; do echo "$i ${ITEM_SIZES[$i]}"; done | sort -k2 -rn | cut -d' ' -f1))

item_num=1
for i in "${indices[@]}"; do
    size_hr="${ITEM_SIZES_HR[$i]}"
    name="${ITEM_NAMES[$i]}"
    note="${ITEM_NOTES[$i]}"
    warning="${ITEM_WARNINGS[$i]}"
    path="${ITEM_PATHS[$i]}"

    # Color code by size
    size_kb="${ITEM_SIZES[$i]}"
    if [ "$size_kb" -ge 1048576 ]; then  # >= 1GB
        size_color="${RED}"
    elif [ "$size_kb" -ge 102400 ]; then  # >= 100MB
        size_color="${YELLOW}"
    else
        size_color="${GREEN}"
    fi

    printf "%2d. ${size_color}%8s${NC}  %-40s\n" "$item_num" "$size_hr" "$name"
    if [ -n "$note" ]; then
        echo -e "             ${CYAN}$note${NC}"
    fi
    if [ -n "$warning" ]; then
        echo -e "             ${YELLOW}Warning: $warning${NC}"
    fi
    if [ "$path" != "__DOCKER__" ]; then
        echo -e "             $path"
    fi
    echo ""
    item_num=$((item_num + 1))
done

# =============================================================================
# INTERACTIVE CLEANUP
# =============================================================================
echo -e "${BOLD}${CYAN}=== CLEANUP OPTIONS ===${NC}"
echo ""
echo -e "Options:"
echo -e "  ${GREEN}a${NC} - Clean ALL items (will confirm each)"
echo -e "  ${GREEN}s${NC} - Select items by number (e.g., 1,2,5 or 1-3)"
echo -e "  ${GREEN}b${NC} - Clean only BIG items (>100MB, will confirm each)"
echo -e "  ${GREEN}q${NC} - Quit without cleaning"
echo ""
echo -e -n "${YELLOW}Choose option: ${NC}"
read -r option

case "$option" in
    [aA])
        selected_indices=("${indices[@]}")
        ;;
    [bB])
        selected_indices=()
        for i in "${indices[@]}"; do
            if [ "${ITEM_SIZES[$i]}" -ge 102400 ]; then
                selected_indices+=("$i")
            fi
        done
        ;;
    [sS])
        echo -e -n "${YELLOW}Enter item numbers (e.g., 1,2,5 or 1-3 or 1,3-5): ${NC}"
        read -r selection
        selected_indices=()
        # Parse selection
        IFS=',' read -ra parts <<< "$selection"
        for part in "${parts[@]}"; do
            part=$(echo "$part" | tr -d ' ')
            if [[ "$part" =~ ^([0-9]+)-([0-9]+)$ ]]; then
                # Range
                start="${BASH_REMATCH[1]}"
                end="${BASH_REMATCH[2]}"
                for ((n=start; n<=end; n++)); do
                    if [ "$n" -ge 1 ] && [ "$n" -le "${#indices[@]}" ]; then
                        selected_indices+=("${indices[$((n-1))]}")
                    fi
                done
            elif [[ "$part" =~ ^[0-9]+$ ]]; then
                # Single number
                if [ "$part" -ge 1 ] && [ "$part" -le "${#indices[@]}" ]; then
                    selected_indices+=("${indices[$((part-1))]}")
                fi
            fi
        done
        ;;
    [qQ]|*)
        echo -e "${RED}Aborted.${NC}"
        exit 0
        ;;
esac

if [ ${#selected_indices[@]} -eq 0 ]; then
    echo -e "${RED}No items selected.${NC}"
    exit 0
fi

echo ""
echo -e "${BOLD}${CYAN}=== CLEANING ===${NC}"
echo ""

# Process selected items
for i in "${selected_indices[@]}"; do
    name="${ITEM_NAMES[$i]}"
    path="${ITEM_PATHS[$i]}"
    size_hr="${ITEM_SIZES_HR[$i]}"
    size_kb="${ITEM_SIZES[$i]}"
    cmd="${ITEM_CMDS[$i]}"
    warning="${ITEM_WARNINGS[$i]}"

    echo -e "${BOLD}$name${NC} (${size_hr})"
    if [ -n "$warning" ]; then
        echo -e "  ${YELLOW}Warning: $warning${NC}"
    fi

    if confirm "  Delete?"; then
        # Use custom command if provided, otherwise rm -rf
        if [ -n "$cmd" ]; then
            eval "$cmd"
        elif [ "$path" = "__DOCKER__" ]; then
            docker system prune -af --volumes 2>/dev/null
        else
            rm -rf "$path"
        fi
        total_freed=$((total_freed + size_kb))
        echo -e "  ${GREEN}Deleted${NC}"
    else
        echo -e "  ${RED}Skipped${NC}"
    fi
    echo ""
done

# =============================================================================
# FINAL SUMMARY
# =============================================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}   Cleanup Complete${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Show new disk status
NEW_DISK_AVAIL=$(df -h / | awk 'NR==2 {print $4}')
NEW_DISK_USED=$(df -h / | awk 'NR==2 {print $5}')
echo -e "${BOLD}Disk status:${NC} ${NEW_DISK_USED} used, ${NEW_DISK_AVAIL} available"
echo -e "${BOLD}Space freed:${NC} $(format_bytes $total_freed)"
echo ""

# Show remaining Claude usage
if [ -d "$HOME/.claude" ]; then
    echo -e "${BOLD}Remaining Claude usage:${NC} $(get_size "$HOME/.claude")"
fi
echo ""
echo -e "${GREEN}Done!${NC}"
