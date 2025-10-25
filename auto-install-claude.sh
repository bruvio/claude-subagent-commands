#!/bin/bash

# Auto-install CLAUDE.md in repositories when Claude is started
# This script should be called automatically when Claude starts in a new directory

set -e

# Get current working directory (allow override via environment variable)
CURRENT_DIR="${CURRENT_DIR:-$(pwd)}"
# Try multiple sources for CLAUDE.md template
CLAUDE_MD_SOURCE="$HOME/.claude/commands/CLAUDE.md"
if [ ! -f "$CLAUDE_MD_SOURCE" ]; then
    # Fallback to the template in this repository
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    CLAUDE_MD_SOURCE="$SCRIPT_DIR/CLAUDE.md"
    if [ "${DEBUG:-}" = "true" ]; then
        echo "[DEBUG] auto-install-claude.sh: Using fallback source: $CLAUDE_MD_SOURCE"
    fi
else
    if [ "${DEBUG:-}" = "true" ]; then
        echo "[DEBUG] auto-install-claude.sh: Using global source: $CLAUDE_MD_SOURCE"
    fi
fi
TARGET_FILE="$CURRENT_DIR/CLAUDE.md"

# Function to check if we're in a git repository
is_git_repo() {
    (cd "$CURRENT_DIR" && git rev-parse --git-dir > /dev/null 2>&1)
}

# Function to check if CLAUDE.md already exists and is identical
claude_md_needs_update() {
    if [ ! -f "$TARGET_FILE" ]; then
        return 0  # File doesn't exist, needs installation
    fi
    
    # Check if source template is newer or different
    if [ ! -f "$CLAUDE_MD_SOURCE" ]; then
        return 1  # No source template available
    fi
    
    # Compare files (returns 0 if identical, 1 if different)
    if cmp -s "$CLAUDE_MD_SOURCE" "$TARGET_FILE"; then
        return 1  # Files are identical, no update needed
    else
        return 0  # Files are different, update needed
    fi
}

# Function to install CLAUDE.md
install_claude_md() {
    local backup_created=false
    
    # Create backup if file exists
    if [ -f "$TARGET_FILE" ]; then
        cp "$TARGET_FILE" "${TARGET_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
        backup_created=true
    fi
    
    # Copy the template
    cp "$CLAUDE_MD_SOURCE" "$TARGET_FILE"
    
    # Log the installation
    if [ -d "$HOME/.claude/logs" ]; then
        if [ "$backup_created" = true ]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] [AUTO-INSTALL] CLAUDE.md updated in $CURRENT_DIR (backup created)" >> "$HOME/.claude/logs/subagent-commands.log"
        else
            echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] [AUTO-INSTALL] CLAUDE.md installed in $CURRENT_DIR" >> "$HOME/.claude/logs/subagent-commands.log"
        fi
    fi
    
    return 0
}

# Main logic
main() {
    # Debug output if DEBUG is set
    if [ "${DEBUG:-}" = "true" ]; then
        echo "[DEBUG] auto-install-claude.sh: Current directory: $CURRENT_DIR"
        echo "[DEBUG] auto-install-claude.sh: CLAUDE_MD_SOURCE: $CLAUDE_MD_SOURCE"
        echo "[DEBUG] auto-install-claude.sh: TARGET_FILE: $TARGET_FILE"
    fi
    
    # Check if we have the source CLAUDE.md template
    if [ ! -f "$CLAUDE_MD_SOURCE" ]; then
        if [ "${DEBUG:-}" = "true" ]; then
            echo "[DEBUG] auto-install-claude.sh: Source template not found, exiting"
        fi
        return 0  # Silently exit if no template is available
    fi
    
    # Check if we're in a git repository or a development directory
    if is_git_repo || [ -f "$CURRENT_DIR/package.json" ] || [ -f "$CURRENT_DIR/requirements.txt" ] || [ -f "$CURRENT_DIR/Cargo.toml" ] || [ -f "$CURRENT_DIR/go.mod" ] || [ -f "$CURRENT_DIR/pom.xml" ]; then
        if [ "${DEBUG:-}" = "true" ]; then
            echo "[DEBUG] auto-install-claude.sh: Detected development directory"
        fi
        # Check if CLAUDE.md needs to be installed or updated
        if claude_md_needs_update; then
            if [ "${DEBUG:-}" = "true" ]; then
                echo "[DEBUG] auto-install-claude.sh: Installing CLAUDE.md"
            fi
            install_claude_md
        else
            if [ "${DEBUG:-}" = "true" ]; then
                echo "[DEBUG] auto-install-claude.sh: CLAUDE.md is up to date"
            fi
        fi
    else
        if [ "${DEBUG:-}" = "true" ]; then
            echo "[DEBUG] auto-install-claude.sh: Not a development directory, skipping"
        fi
    fi
}

# Run main function
main "$@"