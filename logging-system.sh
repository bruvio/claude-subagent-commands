#!/bin/bash

# Claude Subagent Command Logging System
# This script provides centralized logging for all subagent commands

# Configuration
LOG_DIR="$HOME/.claude/logs"
LOG_FILE="$LOG_DIR/subagent-commands.log"
SESSION_LOG="$LOG_DIR/session-$(date +%Y%m%d-%H%M%S).log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
    local level="$1"
    local command="$2"
    local message="$3"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Format: [TIMESTAMP] [LEVEL] [COMMAND] MESSAGE
    echo "[$timestamp] [$level] [$command] $message" >> "$LOG_FILE"
    echo "[$timestamp] [$level] [$command] $message" >> "$SESSION_LOG"
}

# Function to log command start
log_command_start() {
    local command="$1"
    local args="$2"
    local pwd=$(pwd)
    
    log_message "INFO" "$command" "Command started with args: $args"
    log_message "INFO" "$command" "Working directory: $pwd"
    log_message "INFO" "$command" "Session log: $SESSION_LOG"
    
    echo -e "${GREEN}[LOG]${NC} Started command: $command"
    echo -e "${BLUE}[LOG]${NC} Session log: $SESSION_LOG"
}

# Function to log command completion
log_command_complete() {
    local command="$1"
    local duration="$2"
    local status="$3"
    
    log_message "INFO" "$command" "Command completed in $duration seconds with status: $status"
    echo -e "${GREEN}[LOG]${NC} Command completed in $duration seconds"
}

# Function to log errors
log_error() {
    local command="$1"
    local error="$2"
    
    log_message "ERROR" "$command" "Error: $error"
    echo -e "${RED}[ERROR]${NC} $error"
}

# Function to log warnings
log_warning() {
    local command="$1"
    local warning="$2"
    
    log_message "WARN" "$command" "Warning: $warning"
    echo -e "${YELLOW}[WARN]${NC} $warning"
}

# Function to log debug information
log_debug() {
    local command="$1"
    local debug_info="$2"
    
    if [[ "${DEBUG:-false}" == "true" ]]; then
        log_message "DEBUG" "$command" "Debug: $debug_info"
        echo -e "${BLUE}[DEBUG]${NC} $debug_info"
    fi
}

# Function to create command-specific log file
create_command_log() {
    local command="$1"
    local timestamp=$(date '+%Y%m%d-%H%M%S')
    local command_log="$LOG_DIR/${command}-${timestamp}.log"
    
    echo "$command_log"
}

# Function to log command output
log_output() {
    local command="$1"
    local output="$2"
    local log_file="$3"
    
    echo "$output" >> "$log_file"
    log_message "OUTPUT" "$command" "Output logged to: $log_file"
}

# Function to show recent logs
show_recent_logs() {
    local count="${1:-10}"
    echo -e "${BLUE}[LOG]${NC} Recent $count log entries:"
    tail -n "$count" "$LOG_FILE"
}

# Function to show command statistics
show_command_stats() {
    if [[ ! -f "$LOG_FILE" ]]; then
        echo -e "${YELLOW}[LOG]${NC} No log file found"
        return
    fi
    
    echo -e "${BLUE}[LOG]${NC} Command usage statistics:"
    echo "=================================="
    
    # Count by command
    echo "Commands executed:"
    grep -o '\[.*\] \[INFO\] \[.*\] Command started' "$LOG_FILE" | \
    sed 's/.*\[INFO\] \[\(.*\)\] Command started/\1/' | \
    sort | uniq -c | sort -nr
    
    echo ""
    echo "Total commands executed: $(grep -c 'Command started' "$LOG_FILE")"
    echo "Total errors: $(grep -c '\[ERROR\]' "$LOG_FILE")"
    echo "Total warnings: $(grep -c '\[WARN\]' "$LOG_FILE")"
}

# Function to clean old logs
clean_old_logs() {
    local days="${1:-7}"
    echo -e "${BLUE}[LOG]${NC} Cleaning logs older than $days days..."
    
    find "$LOG_DIR" -name "*.log" -mtime +$days -delete
    echo -e "${GREEN}[LOG]${NC} Old logs cleaned"
}

# Export functions for use in other scripts
export -f log_message
export -f log_command_start
export -f log_command_complete
export -f log_error
export -f log_warning
export -f log_debug
export -f create_command_log
export -f log_output

# Export variables
export LOG_DIR
export LOG_FILE
export SESSION_LOG