#!/bin/bash

# Auto-install CLAUDE.md in repositories when Claude is started
# This script should be called automatically when Claude starts in a new directory

set -e

# Get current working directory
CURRENT_DIR="$(pwd)"
CLAUDE_MD_SOURCE="$HOME/.claude/commands/CLAUDE.md"
TARGET_FILE="$CURRENT_DIR/CLAUDE.md"

# Function to check if we're in a git repository
is_git_repo() {
    git rev-parse --git-dir > /dev/null 2>&1
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
    # Check if we have the source CLAUDE.md template
    if [ ! -f "$CLAUDE_MD_SOURCE" ]; then
        return 0  # Silently exit if no template is available
    fi
    
    # Check if we're in a git repository or a development directory
    if is_git_repo || [ -f "package.json" ] || [ -f "requirements.txt" ] || [ -f "Cargo.toml" ] || [ -f "go.mod" ] || [ -f "pom.xml" ]; then
        # Check if CLAUDE.md needs to be installed or updated
        if claude_md_needs_update; then
            install_claude_md
        fi
    fi
}

# Run main function
main "$@"