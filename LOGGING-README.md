# Claude Subagent Commands - Logging System

This enhanced version of the Claude subagent commands includes a comprehensive logging system that captures detailed information about command execution, errors, and performance metrics.

## 📊 What Gets Logged

The logging system captures:
- **Command execution details** (start time, duration, status)
- **Working directory and environment context**
- **Command arguments and parameters**
- **Error messages and warnings**
- **Debug information** (when enabled)
- **Performance metrics**
- **Session information**

## 📁 Log Directory Structure

All logs are stored in `~/.claude/logs/`:

```
~/.claude/logs/
├── subagent-commands.log           # Main log file (all commands)
├── session-YYYYMMDD-HHMMSS.log     # Per-session logs
└── command-YYYYMMDD-HHMMSS.log     # Per-command output logs
```

## 🔧 Installation

The logging system is automatically installed when you run:

```bash
./install-globally.sh
```

This installs:
- `logging-system.sh` - Core logging functionality
- `command-wrapper.sh` - Command execution wrapper
- `log-viewer.sh` - Advanced log viewing utility

## 🎯 Usage

### Running Commands with Logging

Commands automatically log when executed:

```bash
# Examples (these would be used within Claude)
/tech-debt-finder-fixer src/ --type duplicates
/architecture-review --detect-violations
/test-generator --only-untested
```

### Viewing Logs

Use the comprehensive log viewer:

```bash
# View recent logs
~/.claude/commands/log-viewer.sh --recent 20

# View logs for specific command
~/.claude/commands/log-viewer.sh --command tech-debt-finder-fixer

# View only errors
~/.claude/commands/log-viewer.sh --errors

# View today's logs
~/.claude/commands/log-viewer.sh --today

# Follow live logs
~/.claude/commands/log-viewer.sh --follow

# Show usage statistics
~/.claude/commands/log-viewer.sh --stats

# Search for patterns
~/.claude/commands/log-viewer.sh --grep "Command started"

# View specific date
~/.claude/commands/log-viewer.sh --date 2024-01-15

# List all session logs
~/.claude/commands/log-viewer.sh --list-sessions

# Export logs to file
~/.claude/commands/log-viewer.sh --export my-logs.txt
```

## 🎨 Log Format

Logs use a structured format with color coding:

```
[TIMESTAMP] [LEVEL] [COMMAND] MESSAGE
```

**Log Levels:**
- `INFO` - General information (green)
- `ERROR` - Error messages (red)
- `WARN` - Warning messages (yellow)
- `DEBUG` - Debug information (cyan)

**Example Log Entry:**
```
[2024-01-15 14:30:25] [INFO] [tech-debt-finder-fixer] Command started with args: src/ --type duplicates
[2024-01-15 14:30:25] [INFO] [tech-debt-finder-fixer] Working directory: /Users/dev/project
[2024-01-15 14:30:27] [INFO] [tech-debt-finder-fixer] Command completed in 2 seconds with status: SUCCESS
```

## 🧹 Log Management

### Automatic Cleanup

Clean old logs automatically:

```bash
# Clean logs older than 7 days (default)
~/.claude/commands/log-viewer.sh --clean

# Clean logs older than 30 days
~/.claude/commands/log-viewer.sh --clean 30
```

### Manual Cleanup

```bash
# Remove all logs
rm -rf ~/.claude/logs/*

# Remove specific log types
rm ~/.claude/logs/session-*.log
rm ~/.claude/logs/tech-debt-finder-fixer-*.log
```

## 📈 Statistics and Monitoring

The logging system provides detailed statistics:

```bash
~/.claude/commands/log-viewer.sh --stats
```

Shows:
- Most used commands
- Total command executions
- Error/warning counts
- Most active days
- Command success rates

## 🔍 Debug Mode

Enable debug logging for detailed information:

```bash
# Enable debug mode
export DEBUG=true

# Run command with debug logging
/tech-debt-finder-fixer src/

# Disable debug mode
export DEBUG=false
```

## 🎛️ Configuration

### Environment Variables

- `DEBUG` - Enable debug logging (default: false)
- `LOG_DIR` - Custom log directory (default: ~/.claude/logs)

### Log Rotation

The system automatically manages log files:
- Session logs are created per execution
- Command-specific logs capture detailed output
- Main log file contains all activity

## 📋 Log Analysis Examples

### Find Most Common Errors

```bash
~/.claude/commands/log-viewer.sh --errors | grep -o '\[.*\]' | sort | uniq -c | sort -nr
```

### Command Performance Analysis

```bash
~/.claude/commands/log-viewer.sh --grep "Command completed" | grep -o 'in [0-9]* seconds' | sort | uniq -c
```

### Daily Usage Patterns

```bash
~/.claude/commands/log-viewer.sh --grep "Command started" | cut -d' ' -f1-2 | sort | uniq -c
```

## 🚨 Troubleshooting

### Common Issues

1. **Permission Denied**
   ```bash
   chmod +x ~/.claude/commands/*.sh
   ```

2. **Log Directory Not Created**
   ```bash
   mkdir -p ~/.claude/logs
   ```

3. **No Logs Appearing**
   - Check if commands are being run through the wrapper
   - Verify log directory permissions
   - Enable debug mode for more information

### Log Files Not Updating

1. Check if logging system is properly installed:
   ```bash
   ls -la ~/.claude/commands/logging-system.sh
   ```

2. Verify log directory exists:
   ```bash
   ls -la ~/.claude/logs/
   ```

3. Test logging system directly:
   ```bash
   ~/.claude/commands/command-wrapper.sh --help
   ```

## 🔒 Security Considerations

- Logs may contain sensitive information (file paths, command arguments)
- Consider log retention policies for sensitive environments
- Use `--clean` regularly to remove old logs
- Review logs before sharing or exporting

## 📚 Integration Examples

### CI/CD Integration

```yaml
# .github/workflows/subagent-analysis.yml
- name: Run Architecture Review
  run: ~/.claude/commands/command-wrapper.sh architecture-review --detect-violations

- name: Archive Logs
  uses: actions/upload-artifact@v2
  with:
    name: subagent-logs
    path: ~/.claude/logs/
```

### Shell Aliases

```bash
# Add to ~/.bashrc or ~/.zshrc
alias sa-logs='~/.claude/commands/log-viewer.sh'
alias sa-stats='~/.claude/commands/log-viewer.sh --stats'
alias sa-errors='~/.claude/commands/log-viewer.sh --errors'
alias sa-clean='~/.claude/commands/log-viewer.sh --clean'
```

## 🎯 Best Practices

1. **Regular Monitoring**: Check logs regularly for errors and warnings
2. **Log Rotation**: Clean old logs to prevent disk space issues
3. **Performance Tracking**: Monitor command execution times
4. **Error Analysis**: Review error patterns to improve workflows
5. **Debug Mode**: Use sparingly to avoid log bloat

## 📧 Support

For issues with the logging system:
1. Check the troubleshooting section above
2. Review log files for error messages
3. Enable debug mode for detailed information
4. Check file permissions and directory structure

---

The logging system provides comprehensive visibility into your Claude subagent command usage, helping you track performance, debug issues, and optimize your workflow.