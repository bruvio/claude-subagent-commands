#!/bin/bash

# Claude Subagent Log Viewer
# Provides various ways to view and analyze subagent command logs

LOG_DIR="$HOME/.claude/logs"
LOG_FILE="$LOG_DIR/subagent-commands.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Function to show help
show_help() {
    echo "Claude Subagent Log Viewer"
    echo "=========================="
    echo ""
    echo "Usage: $0 [OPTION] [ARGUMENTS]"
    echo ""
    echo "Options:"
    echo "  -r, --recent [N]        Show recent N log entries (default: 10)"
    echo "  -c, --command CMD       Show logs for specific command"
    echo "  -e, --errors            Show only error logs"
    echo "  -w, --warnings          Show only warning logs"
    echo "  -t, --today             Show today's logs"
    echo "  -s, --stats             Show command usage statistics"
    echo "  -f, --follow            Follow log file (like tail -f)"
    echo "  -g, --grep PATTERN      Search logs for pattern"
    echo "  -d, --date DATE         Show logs for specific date (YYYY-MM-DD)"
    echo "  -l, --list-sessions     List all session log files"
    echo "  -v, --session FILE      View specific session log"
    echo "  --clean [DAYS]          Clean logs older than N days (default: 7)"
    echo "  --export [FILE]         Export logs to file"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -r 20                     # Show last 20 entries"
    echo "  $0 -c tech-debt-finder       # Show logs for specific command"
    echo "  $0 -e                        # Show only errors"
    echo "  $0 -t                        # Show today's logs"
    echo "  $0 -g 'Command started'      # Search for pattern"
    echo "  $0 -d 2024-01-15            # Show logs for specific date"
    echo "  $0 --clean 30               # Clean logs older than 30 days"
}

# Function to check if log file exists
check_log_file() {
    if [[ ! -f "$LOG_FILE" ]]; then
        echo -e "${YELLOW}[WARN]${NC} No log file found at $LOG_FILE"
        echo "Run a subagent command first to generate logs."
        return 1
    fi
    return 0
}

# Function to show recent logs
show_recent() {
    local count="${1:-10}"
    check_log_file || return 1
    
    echo -e "${BLUE}[INFO]${NC} Recent $count log entries:"
    echo "========================================"
    
    tail -n "$count" "$LOG_FILE" | while IFS= read -r line; do
        # Color code by log level
        if [[ "$line" =~ \[ERROR\] ]]; then
            echo -e "${RED}$line${NC}"
        elif [[ "$line" =~ \[WARN\] ]]; then
            echo -e "${YELLOW}$line${NC}"
        elif [[ "$line" =~ \[INFO\] ]]; then
            echo -e "${GREEN}$line${NC}"
        elif [[ "$line" =~ \[DEBUG\] ]]; then
            echo -e "${CYAN}$line${NC}"
        else
            echo "$line"
        fi
    done
}

# Function to show logs for specific command
show_command_logs() {
    local command="$1"
    check_log_file || return 1
    
    echo -e "${BLUE}[INFO]${NC} Logs for command: $command"
    echo "========================================"
    
    grep "\[$command\]" "$LOG_FILE" | while IFS= read -r line; do
        if [[ "$line" =~ \[ERROR\] ]]; then
            echo -e "${RED}$line${NC}"
        elif [[ "$line" =~ \[WARN\] ]]; then
            echo -e "${YELLOW}$line${NC}"
        else
            echo -e "${GREEN}$line${NC}"
        fi
    done
}

# Function to show only errors
show_errors() {
    check_log_file || return 1
    
    echo -e "${RED}[ERROR]${NC} Error logs:"
    echo "================================"
    
    grep "\[ERROR\]" "$LOG_FILE" | while IFS= read -r line; do
        echo -e "${RED}$line${NC}"
    done
}

# Function to show only warnings
show_warnings() {
    check_log_file || return 1
    
    echo -e "${YELLOW}[WARN]${NC} Warning logs:"
    echo "==================================="
    
    grep "\[WARN\]" "$LOG_FILE" | while IFS= read -r line; do
        echo -e "${YELLOW}$line${NC}"
    done
}

# Function to show today's logs
show_today() {
    check_log_file || return 1
    
    local today=$(date +%Y-%m-%d)
    echo -e "${BLUE}[INFO]${NC} Today's logs ($today):"
    echo "========================================"
    
    grep "^\\[$today" "$LOG_FILE" | while IFS= read -r line; do
        if [[ "$line" =~ \[ERROR\] ]]; then
            echo -e "${RED}$line${NC}"
        elif [[ "$line" =~ \[WARN\] ]]; then
            echo -e "${YELLOW}$line${NC}"
        else
            echo -e "${GREEN}$line${NC}"
        fi
    done
}

# Function to show statistics
show_stats() {
    check_log_file || return 1
    
    echo -e "${PURPLE}[STATS]${NC} Command Usage Statistics:"
    echo "=========================================="
    
    # Commands executed
    echo "Commands executed:"
    grep "Command started" "$LOG_FILE" | \
    sed 's/.*\[\(.*\)\] Command started.*/\1/' | \
    sort | uniq -c | sort -nr | head -10
    
    echo ""
    echo "Summary:"
    echo "--------"
    echo "Total commands: $(grep -c "Command started" "$LOG_FILE")"
    echo "Total errors: $(grep -c "\[ERROR\]" "$LOG_FILE")"
    echo "Total warnings: $(grep -c "\[WARN\]" "$LOG_FILE")"
    echo "Most active day: $(grep "Command started" "$LOG_FILE" | sed 's/^\[\([0-9-]*\).*/\1/' | sort | uniq -c | sort -nr | head -1)"
}

# Function to follow logs
follow_logs() {
    check_log_file || return 1
    
    echo -e "${BLUE}[INFO]${NC} Following log file (Ctrl+C to stop):"
    echo "=========================================="
    
    tail -f "$LOG_FILE" | while IFS= read -r line; do
        if [[ "$line" =~ \[ERROR\] ]]; then
            echo -e "${RED}$line${NC}"
        elif [[ "$line" =~ \[WARN\] ]]; then
            echo -e "${YELLOW}$line${NC}"
        else
            echo -e "${GREEN}$line${NC}"
        fi
    done
}

# Function to search logs
search_logs() {
    local pattern="$1"
    check_log_file || return 1
    
    echo -e "${BLUE}[INFO]${NC} Searching for pattern: $pattern"
    echo "=========================================="
    
    grep -i "$pattern" "$LOG_FILE" | while IFS= read -r line; do
        if [[ "$line" =~ \[ERROR\] ]]; then
            echo -e "${RED}$line${NC}"
        elif [[ "$line" =~ \[WARN\] ]]; then
            echo -e "${YELLOW}$line${NC}"
        else
            echo -e "${GREEN}$line${NC}"
        fi
    done
}

# Function to show logs for specific date
show_date() {
    local date="$1"
    check_log_file || return 1
    
    echo -e "${BLUE}[INFO]${NC} Logs for date: $date"
    echo "========================================"
    
    grep "^\\[$date" "$LOG_FILE" | while IFS= read -r line; do
        if [[ "$line" =~ \[ERROR\] ]]; then
            echo -e "${RED}$line${NC}"
        elif [[ "$line" =~ \[WARN\] ]]; then
            echo -e "${YELLOW}$line${NC}"
        else
            echo -e "${GREEN}$line${NC}"
        fi
    done
}

# Function to list session files
list_sessions() {
    echo -e "${BLUE}[INFO]${NC} Session log files:"
    echo "================================="
    
    if [[ -d "$LOG_DIR" ]]; then
        find "$LOG_DIR" -name "session-*.log" -exec basename {} \; | sort -r | head -20
    else
        echo "No session logs found"
    fi
}

# Function to view specific session
view_session() {
    local session_file="$1"
    local full_path="$LOG_DIR/$session_file"
    
    if [[ ! -f "$full_path" ]]; then
        echo -e "${RED}[ERROR]${NC} Session file not found: $full_path"
        return 1
    fi
    
    echo -e "${BLUE}[INFO]${NC} Session log: $session_file"
    echo "========================================"
    
    cat "$full_path" | while IFS= read -r line; do
        if [[ "$line" =~ \[ERROR\] ]]; then
            echo -e "${RED}$line${NC}"
        elif [[ "$line" =~ \[WARN\] ]]; then
            echo -e "${YELLOW}$line${NC}"
        else
            echo -e "${GREEN}$line${NC}"
        fi
    done
}

# Function to clean old logs
clean_logs() {
    local days="${1:-7}"
    
    echo -e "${BLUE}[INFO]${NC} Cleaning logs older than $days days..."
    
    if [[ -d "$LOG_DIR" ]]; then
        find "$LOG_DIR" -name "*.log" -mtime +$days -delete
        echo -e "${GREEN}[SUCCESS]${NC} Old logs cleaned"
    else
        echo -e "${YELLOW}[WARN]${NC} Log directory not found"
    fi
}

# Function to export logs
export_logs() {
    local output_file="${1:-subagent-logs-$(date +%Y%m%d).txt}"
    check_log_file || return 1
    
    echo -e "${BLUE}[INFO]${NC} Exporting logs to: $output_file"
    
    {
        echo "Claude Subagent Command Logs"
        echo "Generated: $(date)"
        echo "=================================="
        echo ""
        cat "$LOG_FILE"
    } > "$output_file"
    
    echo -e "${GREEN}[SUCCESS]${NC} Logs exported to: $output_file"
}

# Main function
main() {
    case "$1" in
        -r|--recent)
            show_recent "$2"
            ;;
        -c|--command)
            show_command_logs "$2"
            ;;
        -e|--errors)
            show_errors
            ;;
        -w|--warnings)
            show_warnings
            ;;
        -t|--today)
            show_today
            ;;
        -s|--stats)
            show_stats
            ;;
        -f|--follow)
            follow_logs
            ;;
        -g|--grep)
            search_logs "$2"
            ;;
        -d|--date)
            show_date "$2"
            ;;
        -l|--list-sessions)
            list_sessions
            ;;
        -v|--session)
            view_session "$2"
            ;;
        --clean)
            clean_logs "$2"
            ;;
        --export)
            export_logs "$2"
            ;;
        -h|--help|"")
            show_help
            ;;
        *)
            echo -e "${RED}[ERROR]${NC} Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"