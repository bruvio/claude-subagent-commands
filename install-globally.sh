#!/bin/bash

# Claude Subagents Global Installation Script
# This script makes the subagent commands globally available for Claude code terminal

set -e

echo "🚀 Installing Claude Subagents Globally..."

# Create global commands directory
COMMANDS_DIR="$HOME/.claude/commands"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create the directory if it doesn't exist
mkdir -p "$COMMANDS_DIR"

# Copy all subagent files to the global commands directory
echo "📁 Copying subagent files to $COMMANDS_DIR..."

cp "$SCRIPT_DIR/sub-agent-tech-debt-finder-fixer.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/sub-agent-architecture-reviewer.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/sub-agent-test-generator.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/sub-agent-performance-optimizer.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/sub-agent-migration-assistant.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/sub-agent-refactor.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/sub-agent-new-feature.md" "$COMMANDS_DIR/"

echo "✅ Subagent commands installed successfully!"

# List the available commands
echo ""
echo "📋 Available Subagent Commands:"
echo "================================"
echo "1. @tech-debt-finder-fixer  (aliases: @td-finder-fixer, @satdff)"
echo "2. @architecture-review     (aliases: @arch-review, @saar)"
echo "3. @test-generator          (aliases: @test-gen, @satg)"
echo "4. @performance-optimizer   (aliases: @perf-optimize, @sapo)"
echo "5. @migration-assistant     (aliases: @migrate, @sama)"
echo "6. @refactor                (aliases: @sar)"
echo "7. @new-feature             (aliases: @sanf)"
echo ""

echo "🎯 Usage Examples:"
echo "=================="
echo "# Find and fix technical debt"
echo "@tech-debt-finder-fixer src/"
echo ""
echo "# Review architecture"
echo "@arch-review --detect-violations"
echo ""
echo "# Generate tests for untested code"
echo "@test-gen --only-untested"
echo ""
echo "# Optimize performance"
echo "@perf-optimize --bundle-analysis"
echo ""
echo "# Migrate frameworks"
echo "@migrate --from react@17 --to react@18"
echo ""
echo "# Refactor code intelligently"
echo "@refactor src/components/ --type extract-component"
echo ""
echo "# Build new features with AI"
echo "@new-feature --feature \"user dashboard\" --location src/pages/"
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