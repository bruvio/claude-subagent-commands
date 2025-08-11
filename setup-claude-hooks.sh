#!/bin/bash

# Setup Claude hooks to automatically install CLAUDE.md when starting Claude in repositories
# This script configures Claude to run the auto-installation on startup

set -e

echo "🔗 Setting up Claude Auto-Install Hooks..."

# Create hooks directory
HOOKS_DIR="$HOME/.claude/hooks"
CONFIG_DIR="$HOME/.claude/config"
COMMANDS_DIR="$HOME/.claude/commands"

mkdir -p "$HOOKS_DIR"
mkdir -p "$CONFIG_DIR"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy auto-install script to commands directory
echo "📁 Installing auto-install script..."
cp "$SCRIPT_DIR/auto-install-claude.sh" "$COMMANDS_DIR/auto-install-claude.sh"
chmod +x "$COMMANDS_DIR/auto-install-claude.sh"

# Create session start hook
echo "🪝 Creating session start hook..."
cat > "$HOOKS_DIR/session-start.sh" << 'EOF'
#!/bin/bash

# Auto-install CLAUDE.md when Claude starts in a new directory
# This runs silently and only installs if we're in a development project

# Run the auto-install script
if [ -x "$HOME/.claude/commands/auto-install-claude.sh" ]; then
    "$HOME/.claude/commands/auto-install-claude.sh"
fi
EOF

chmod +x "$HOOKS_DIR/session-start.sh"

# Create Claude settings configuration for hooks
echo "⚙️ Configuring Claude settings..."
CLAUDE_SETTINGS="$CONFIG_DIR/settings.json"

# Create or update settings.json
if [ -f "$CLAUDE_SETTINGS" ]; then
    # Backup existing settings
    cp "$CLAUDE_SETTINGS" "${CLAUDE_SETTINGS}.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Create new settings with hooks configuration
cat > "$CLAUDE_SETTINGS" << EOF
{
  "hooks": {
    "session_start": "$HOOKS_DIR/session-start.sh"
  },
  "auto_install": {
    "enabled": true,
    "claude_md_template": "$COMMANDS_DIR/CLAUDE.md"
  }
}
EOF

# Log the setup
if [ -d "$HOME/.claude/logs" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] [SETUP] Claude auto-install hooks configured" >> "$HOME/.claude/logs/subagent-commands.log"
fi

echo "✅ Claude Auto-Install Hooks Setup Complete!"
echo ""
echo "🎯 What's configured:"
echo "====================="
echo "✓ Auto-install script: ~/.claude/commands/auto-install-claude.sh"
echo "✓ Session start hook: ~/.claude/hooks/session-start.sh"
echo "✓ Claude settings: ~/.claude/config/settings.json"
echo ""
echo "📋 How it works:"
echo "================"
echo "• When you start Claude in any directory"
echo "• The hook detects if it's a development project (git repo, package.json, etc.)"
echo "• Automatically installs/updates CLAUDE.md from your template"
echo "• Creates backups if CLAUDE.md already exists"
echo "• Runs silently - no interruption to your workflow"
echo ""
echo "🔧 Manual commands still available:"
echo "==================================="
echo "/install-claude-settings - Manual installation with prompts"
echo ""
echo "🎉 Now CLAUDE.md will be automatically available in every repo!"
EOF