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

# Create aliases for shorter commands
cp "$SCRIPT_DIR/sub-agent-tech-debt-finder-fixer.md" "$COMMANDS_DIR/td-finder-fixer.md"
cp "$SCRIPT_DIR/sub-agent-architecture-reviewer.md" "$COMMANDS_DIR/arch-review.md"
cp "$SCRIPT_DIR/sub-agent-test-generator.md" "$COMMANDS_DIR/test-gen.md"
cp "$SCRIPT_DIR/sub-agent-performance-optimizer.md" "$COMMANDS_DIR/perf-optimize.md"
cp "$SCRIPT_DIR/sub-agent-migration-assistant.md" "$COMMANDS_DIR/migrate.md"

# Create shortest aliases
cp "$SCRIPT_DIR/sub-agent-tech-debt-finder-fixer.md" "$COMMANDS_DIR/satdff.md"
cp "$SCRIPT_DIR/sub-agent-architecture-reviewer.md" "$COMMANDS_DIR/saar.md"
cp "$SCRIPT_DIR/sub-agent-test-generator.md" "$COMMANDS_DIR/satg.md"
cp "$SCRIPT_DIR/sub-agent-performance-optimizer.md" "$COMMANDS_DIR/sapo.md"
cp "$SCRIPT_DIR/sub-agent-migration-assistant.md" "$COMMANDS_DIR/sama.md"
cp "$SCRIPT_DIR/sub-agent-refactor.md" "$COMMANDS_DIR/sar.md"
cp "$SCRIPT_DIR/sub-agent-new-feature.md" "$COMMANDS_DIR/sanf.md"

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
echo "1. /tech-debt-finder-fixer  (aliases: /td-finder-fixer, /satdff)"
echo "2. /architecture-review     (aliases: /arch-review, /saar)"
echo "3. /test-generator          (aliases: /test-gen, /satg)"
echo "4. /performance-optimizer   (aliases: /perf-optimize, /sapo)"
echo "5. /migration-assistant     (aliases: /migrate, /sama)"
echo "6. /refactor                (aliases: /sar)"
echo "7. /new-feature             (aliases: /sanf)"
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
echo "# Find and fix technical debt"
echo "/tech-debt-finder-fixer src/"
echo ""
echo "# Review architecture"
echo "/arch-review --detect-violations"
echo ""
echo "# Generate tests for untested code"
echo "/test-gen --only-untested"
echo ""
echo "# Optimize performance"
echo "/perf-optimize --bundle-analysis"
echo ""
echo "# Migrate frameworks"
echo "/migrate --from react@17 --to react@18"
echo ""
echo "# Refactor code intelligently"
echo "/refactor src/components/ --type extract-component"
echo ""
echo "# Build new features with AI"
echo "/new-feature --feature \"user dashboard\" --location src/pages/"
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