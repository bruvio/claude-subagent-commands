#!/bin/bash

# Claude Subagents Global Installation Script
# This script makes the subagent commands globally available for Claude code terminal
# Now includes comprehensive logging system

set -e

echo "🚀 Installing Claude Subagents Globally with Logging..."

# Create global commands directory
COMMANDS_DIR="$HOME/.claude/commands"
LOG_DIR="$HOME/.claude/logs"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create the directories if they don't exist
mkdir -p "$COMMANDS_DIR"
mkdir -p "$LOG_DIR"

# Clean up old command files
echo "🧹 Cleaning up old command files..."
rm -f "$COMMANDS_DIR/saar.md" \
      "$COMMANDS_DIR/sama.md" \
      "$COMMANDS_DIR/sanf.md" \
      "$COMMANDS_DIR/sapo.md" \
      "$COMMANDS_DIR/sar.md" \
      "$COMMANDS_DIR/satdff.md" \
      "$COMMANDS_DIR/satg.md" \
      "$COMMANDS_DIR/arch-review.md" \
      "$COMMANDS_DIR/migrate.md" \
      "$COMMANDS_DIR/perf-optimize.md" \
      "$COMMANDS_DIR/td-finder-fixer.md" \
      "$COMMANDS_DIR/test-gen.md" \
      "$COMMANDS_DIR/sub-agent-"*.md

# Install logging system
echo "📊 Installing logging system..."
cp "$SCRIPT_DIR/logging-system.sh" "$COMMANDS_DIR/logging-system.sh"
cp "$SCRIPT_DIR/command-wrapper.sh" "$COMMANDS_DIR/command-wrapper.sh"
cp "$SCRIPT_DIR/log-viewer.sh" "$COMMANDS_DIR/log-viewer.sh"
chmod +x "$COMMANDS_DIR/logging-system.sh"
chmod +x "$COMMANDS_DIR/command-wrapper.sh"
chmod +x "$COMMANDS_DIR/log-viewer.sh"

# Copy all subagent files to the global commands directory with proper command names
echo "📁 Copying subagent files to $COMMANDS_DIR..."

cp "$SCRIPT_DIR/sub-agent-tech-debt-finder-fixer.md" "$COMMANDS_DIR/tech-debt-finder-fixer.md"
cp "$SCRIPT_DIR/sub-agent-architecture-reviewer.md" "$COMMANDS_DIR/architecture-review.md"
cp "$SCRIPT_DIR/sub-agent-test-generator.md" "$COMMANDS_DIR/test-generator.md"
cp "$SCRIPT_DIR/sub-agent-performance-optimizer.md" "$COMMANDS_DIR/performance-optimizer.md"
cp "$SCRIPT_DIR/sub-agent-migration-assistant.md" "$COMMANDS_DIR/migration-assistant.md"
cp "$SCRIPT_DIR/sub-agent-refactor.md" "$COMMANDS_DIR/refactor.md"
cp "$SCRIPT_DIR/sub-agent-new-feature.md" "$COMMANDS_DIR/new-feature.md"

# Copy CLAUDE.md template and new PRP commands
echo "📁 Copying CLAUDE settings and PRP commands..."
cp "$SCRIPT_DIR/CLAUDE.md" "$COMMANDS_DIR/CLAUDE.md"
cp "$SCRIPT_DIR/install-claude-settings.md" "$COMMANDS_DIR/install-claude-settings.md"
cp "$SCRIPT_DIR/execute-prp-command.md" "$COMMANDS_DIR/execute-prp.md"
cp "$SCRIPT_DIR/generate-prp-command.md" "$COMMANDS_DIR/generate-prp.md"




echo "✅ Subagent commands installed successfully!"

# Initialize logging system
echo "🔧 Initializing logging system..."
"$COMMANDS_DIR/logging-system.sh"

# Create initial log entry
echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] [INSTALLER] Claude Subagents installed successfully" >> "$LOG_DIR/subagent-commands.log"

# List the available commands
echo ""
echo "📋 Available Subagent Commands:"
echo "================================"
echo "1. /refactor                - Intelligent code refactoring"
echo "2. /new-feature             - Build new features with AI"
echo ""
echo "📋 Project Setup Commands:"
echo "============================"
echo "8. /install-claude-settings - Install CLAUDE.md in new repositories"
echo ""
echo "📋 PRP (Product Requirements & Planning) Commands:"
echo "=================================================="
echo "9. /generate-prp            - Generate comprehensive PRP documents"
echo "10. /execute-prp             - Execute PRP documents to implement features"
echo ""
echo "📊 Logging Commands:"
echo "===================="
echo "- View recent logs: ~/.claude/commands/log-viewer.sh --recent [count]"
echo "- Show statistics: ~/.claude/commands/log-viewer.sh --stats"
echo "- View errors only: ~/.claude/commands/log-viewer.sh --errors"
echo "- Follow live logs: ~/.claude/commands/log-viewer.sh --follow"
echo "- Clean old logs: ~/.claude/commands/log-viewer.sh --clean [days]"
echo "- Full log viewer help: ~/.claude/commands/log-viewer.sh --help"
echo ""

echo "🎯 Usage Examples:"
echo "=================="
echo "# Refactor code intelligently"
echo "/refactor src/components/ --type extract-component"
echo ""
echo "# Build new features with AI"
echo "/new-feature --feature \"user dashboard\" --location src/pages/"
echo ""
echo "# Install CLAUDE.md in new project"
echo "/install-claude-settings"
echo "/install-claude-settings /path/to/new/project"
echo ""
echo "# Generate PRP for feature planning"
echo "/generate-prp features/user-authentication.md"
echo ""
echo "# Execute PRP to implement feature"
echo "/execute-prp PRPs/user-authentication.md"
echo ""

echo "🔧 Setup Complete!"
echo "You can now use these subagent commands in any Claude code terminal session."

# Make the script executable and add to PATH if needed
if [[ ":$PATH:" != *":$HOME/.claude/commands:"* ]]; then
    echo ""
    echo "💡 Optional: Add to your shell profile for easier access:"
    echo "echo 'export PATH=\"\$HOME/.claude/commands:\$PATH\"' >> ~/.bashrc"
    echo "# or for zsh:"
    echo "echo 'export PATH=\"\$HOME/.claude/commands:\$PATH\"' >> ~/.zshrc"
fi