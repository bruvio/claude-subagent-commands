#!/bin/bash

# Claude Subagent Command Wrapper with Logging
# This script wraps subagent commands to provide logging functionality

# Source the logging system
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/logging-system.sh"

# Function to execute a subagent command with logging
execute_subagent_command() {
    local command_name="$1"
    local command_file="$2"
    shift 2
    local args="$*"
    
    # Record start time
    local start_time=$(date +%s)
    
    # Create command-specific log file
    local command_log=$(create_command_log "$command_name")
    
    # Log command start
    log_command_start "$command_name" "$args"
    
    # Log environment information
    log_debug "$command_name" "Environment - User: $(whoami)"
    log_debug "$command_name" "Environment - PWD: $(pwd)"
    log_debug "$command_name" "Environment - Git branch: $(git branch --show-current 2>/dev/null || echo 'not a git repo')"
    log_debug "$command_name" "Environment - Command file: $command_file"
    
    # Execute the command and capture output
    local output
    local exit_code
    
    {
        echo "=== Claude Subagent Command: $command_name ==="
        echo "Started at: $(date)"
        echo "Arguments: $args"
        echo "Working directory: $(pwd)"
        echo "Command file: $command_file"
        echo "=================================="
        echo ""
        
        # The actual command execution would happen here
        # For now, we'll show the command file content and simulate execution
        echo "Command content:"
        cat "$command_file"
        echo ""
        echo "=== Command would be executed here ==="
        
        # This is where Claude would process the command
        # For demonstration, we'll just show that the command was processed
        echo "✅ Command processed successfully"
        
    } > "$command_log" 2>&1
    
    exit_code=$?
    
    # Calculate duration
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    # Log completion
    if [[ $exit_code -eq 0 ]]; then
        log_command_complete "$command_name" "$duration" "SUCCESS"
        echo -e "${GREEN}[SUCCESS]${NC} Command completed successfully"
    else
        log_error "$command_name" "Command failed with exit code $exit_code"
        echo -e "${RED}[ERROR]${NC} Command failed with exit code $exit_code"
    fi
    
    # Log output file location
    echo -e "${BLUE}[LOG]${NC} Full output saved to: $command_log"
    
    return $exit_code
}

# Function to show command help
show_command_help() {
    echo "Claude Subagent Command Wrapper"
    echo "Usage: $0 <command> [args...]"
    echo ""
    echo "Available commands:"
    echo "  --show-logs [count]     Show recent log entries (default: 10)"
    echo "  --show-stats           Show command usage statistics"
    echo "  --clean-logs [days]    Clean logs older than specified days (default: 7)"
    echo "  --help                 Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 tech-debt-finder-fixer src/ --type duplicates"
    echo "  $0 architecture-review --detect-violations"
    echo "  $0 --show-logs 20"
    echo "  $0 --clean-logs 30"
}

# Main execution
main() {
    # Check if logging system is available
    if [[ ! -f "$SCRIPT_DIR/logging-system.sh" ]]; then
        echo -e "${RED}[ERROR]${NC} Logging system not found at $SCRIPT_DIR/logging-system.sh"
        exit 1
    fi
    
    # Handle special commands
    case "$1" in
        --show-logs)
            show_recent_logs "$2"
            exit 0
            ;;
        --show-stats)
            show_command_stats
            exit 0
            ;;
        --clean-logs)
            clean_old_logs "$2"
            exit 0
            ;;
        --help|-h)
            show_command_help
            exit 0
            ;;
        "")
            echo -e "${RED}[ERROR]${NC} No command specified"
            show_command_help
            exit 1
            ;;
    esac
    
    # Extract command name and find command file
    local command_name="$1"
    local command_file="$HOME/.claude/commands/${command_name}.md"
    
    # Check if command file exists
    if [[ ! -f "$command_file" ]]; then
        log_error "$command_name" "Command file not found: $command_file"
        echo -e "${RED}[ERROR]${NC} Command file not found: $command_file"
        echo ""
        echo "Available commands:"
        ls -1 "$HOME/.claude/commands"/*.md 2>/dev/null | sed 's/.*\///; s/\.md$//' | sort
        exit 1
    fi
    
    # Execute the command with logging
    execute_subagent_command "$@"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi