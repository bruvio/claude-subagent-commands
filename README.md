# Claude Subagent Commands

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Status](https://img.shields.io/badge/status-active-brightgreen.svg)
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue.svg)

> **Advanced multi-agent orchestration system for complex software engineering tasks with comprehensive logging, planning, and automation capabilities.**

---

## 📋 Table of Contents

- [🚀 Quick Start](#-quick-start)
- [📦 Installation & Setup](#-installation--setup)
- [🎯 Core Features](#-core-features)
  - [Multi-Agent Commands](#multi-agent-commands)
  - [Logging & Monitoring System](#logging--monitoring-system)
  - [PRP Planning System](#prp-product-requirements--planning-system)
  - [Code Review & Analysis Commands](#code-review--analysis-commands)
  - [Configuration Management](#configuration-management)
- [🏗️ System Architecture](#️-system-architecture)
- [📚 Command Reference](#-command-reference)
- [🔧 Advanced Usage](#-advanced-usage)
- [🚨 Troubleshooting](#-troubleshooting)
- [💡 Best Practices](#-best-practices)
- [🤝 Contributing](#-contributing)
- [📝 License](#-license)

---

## 🚀 Quick Start

Get started with claude-subagent-commands in under 5 minutes:

```bash
# 1. Clone and install
git clone https://github.com/bruvio/claude-subagent-commands.git
cd claude-subagent-commands
./install-globally.sh

# 2. Verify installation
~/.claude/commands/log-viewer.sh --help

# 3. Run your first command
@tech-debt-finder-fixer src/ --dry-run
```

**Expected output**: Installation confirmation with logging system setup and command availability verification.

---

## 📦 Installation & Setup

### Prerequisites

- **Claude Code**: Latest version installed and configured
- **Operating System**: macOS, Linux (Windows via WSL)
- **Shell**: Bash or Zsh
- **Optional**: Docker for enhanced testing capabilities

### Installation Methods

#### Standard Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/bruvio/claude-subagent-commands.git
cd claude-subagent-commands

# Global installation with logging system
./install-globally.sh
```

#### Custom Installation with Configuration

```bash
# Install with custom directories
./install-globally.sh

# Configure PRP storage locations
/config-prp-storage --base-dir ~/my-claude-workspace

# Set up automatic CLAUDE.md installation
./setup-claude-hooks.sh
```

### Installation Verification

Verify your installation works correctly:

```bash
# Check core installation
ls -la ~/.claude/commands/

# Verify logging system
~/.claude/commands/log-viewer.sh --stats

# Test a simple command
@tech-debt-finder-fixer --help
```

**Expected Results**:
- Commands directory populated with scripts
- Logging system operational
- Help text displays correctly

### Troubleshooting Installation

#### Common Installation Issues

**Permission Denied Errors**:
```bash
chmod +x ~/.claude/commands/*.sh
sudo chown -R $USER ~/.claude/
```

**Commands Not Found**:
```bash
# Re-run installation
./install-globally.sh

# Verify PATH includes Claude commands
echo $PATH | grep .claude
```

**Logging System Not Working**:
```bash
# Check logging components
ls -la ~/.claude/commands/logging-system.sh
mkdir -p ~/.claude/logs
~/.claude/commands/command-wrapper.sh --help
```

---

## 🎯 Core Features

### Multi-Agent Commands

Specialized AI agents orchestrated for complex software engineering tasks:

#### 1. Tech Debt Finder & Fixer
**Aliases:** `@tech-debt-finder-fixer`, `@td-finder-fixer`, `@satdff`

Identifies and fixes technical debt through coordinated multi-agent analysis:

- **Phase 1**: 5 parallel agents analyze code for duplicates, complexity, patterns, dead code, and type coverage
- **Phase 2**: Specialized fix agents safely refactor code with automated testing

```bash
# Find and fix tech debt with review
@tech-debt-finder-fixer

# Quick wins only - safe fixes
@tech-debt-finder-fixer --auto-fix safe --fix-order quick-wins

# Custom test command
@tech-debt-finder-fixer src/ --test-command "npm test && npm run lint"
```

**Performance**: 2-10 minutes for full codebase scan

#### 2. Architecture Reviewer
**Aliases:** `@architecture-review`, `@arch-review`, `@saar`

Analyzes system architecture and generates visual documentation:

```bash
# Basic architecture review
@architecture-review

# Full analysis with violations detection
@arch-review src/ --detect-violations --suggest-improvements

# Generate diagrams
@architecture-review --style hexagonal --visualize --output mermaid
```

**Capabilities**:
- Dependency mapping and circular dependency detection
- Pattern analysis (MVC, Hexagonal, DDD compliance)
- Complexity metrics and cognitive load assessment
- Generates Mermaid/PlantUML diagrams

#### 3. Test Generator
**Aliases:** `@test-gen`, `@test-generator`, `@satg`

Generates comprehensive test suites through intelligent code analysis:

```bash
# Generate missing unit tests
@test-gen src/services/ --only-untested

# Target specific coverage
@test-gen src/ --coverage-target 90 --type unit

# Generate E2E tests
@test-gen --type e2e --from-flows src/features/
```

#### 4. Performance Optimizer
**Aliases:** `@perf-optimize`, `@performance`, `@sapo`

Full-stack performance optimization:

```bash
# Frontend optimization
@perf-optimize src/ --target frontend --bundle-analysis

# Database optimization
@perf-optimize --target database --suggest-indexes

# Comprehensive optimization
@performance . --baseline perf-baseline.json
```

#### 5. Migration Assistant
**Aliases:** `@migrate`, `@migration-assistant`, `@sama`

Framework and library migration support:

```bash
# React version migration
@migrate --from react@17 --to react@18 --safe-mode

# Pattern migration
@migrate --pattern class-to-hooks src/components/

# Laravel upgrade
@migrate --from laravel@8 --to laravel@10 --incremental
```

#### 6. Intelligent Refactor
**Aliases:** `@refactor`, `@sar`

Safe, intelligent code refactoring:

```bash
# Auto-detect and refactor
@refactor src/components/UserDashboard.tsx

# Extract repeated code
@refactor src/pages/ --type extract-method --create-shared

# Reduce complexity
@refactor src/utils/ --type reduce-complexity --max-function-size 20
```

#### 7. New Feature Builder
**Aliases:** `@new-feature`, `@sanf`

Builds features by learning from existing code:

```bash
# Add feature component
@new-feature --feature "User profile card with avatar and stats" --location src/components/

# Full-stack feature
@new-feature \
  --feature "Comment system with real-time updates" \
  --location src/features/comments \
  --type full-stack \
  --test-first
```

### Logging & Monitoring System

Comprehensive logging infrastructure for monitoring command execution, debugging, and performance analysis.

#### Key Features
- **Real-time monitoring** - Live command execution tracking
- **Performance metrics** - Execution times and success rates
- **Advanced querying** - Rich log search and filtering capabilities
- **Automated cleanup** - Configurable log retention policies
- **Session tracking** - Per-command and per-session logging

#### Log Directory Structure
```
~/.claude/logs/
├── subagent-commands.log           # Main log file (all commands)
├── session-YYYYMMDD-HHMMSS.log     # Per-session logs
└── command-YYYYMMDD-HHMMSS.log     # Per-command output logs
```

#### Quick Usage Examples

```bash
# View recent activity
~/.claude/commands/log-viewer.sh --recent 20

# Monitor specific command
~/.claude/commands/log-viewer.sh --command tech-debt-finder-fixer

# View performance statistics
~/.claude/commands/log-viewer.sh --stats

# View only errors
~/.claude/commands/log-viewer.sh --errors

# Follow live logs
~/.claude/commands/log-viewer.sh --follow

# Clean old logs (older than 7 days)
~/.claude/commands/log-viewer.sh --clean
```

#### Advanced Log Analysis

```bash
# Search for patterns
~/.claude/commands/log-viewer.sh --grep "Command started"

# View specific date
~/.claude/commands/log-viewer.sh --date 2024-01-15

# Export logs
~/.claude/commands/log-viewer.sh --export my-analysis.txt

# Usage statistics
~/.claude/commands/log-viewer.sh --stats
```

**Statistics Include**:
- Most used commands
- Total command executions
- Error/warning counts
- Command success rates
- Performance trends

### PRP (Product Requirements & Planning) System

Advanced planning and implementation framework for complex development tasks.

#### Overview
The PRP system enables comprehensive feature planning with automated implementation, combining:
- **Deep research** (30-100 page documentation requirement)
- **Codebase pattern analysis** 
- **Implementation planning** with ULTRATHINK methodology
- **Automated execution** with validation gates

#### Commands

##### Generate PRP (`/generate-prp`)
Create comprehensive implementation plans:

```bash
# Generate PRP from feature description
/generate-prp "implement user authentication system"

# Generate with custom directories
/generate-prp features/dashboard.md --base-dir ~/my-prp-workspace

# Generate from requirements file
/generate-prp requirements/api-integration.txt
```

**Process**:
1. **Feature Analysis** - Requirements extraction and scope definition
2. **Comprehensive Research** - 30-100 pages of official documentation
3. **Codebase Pattern Analysis** - Existing conventions and integration points
4. **ULTRATHINK Planning** - Advanced implementation strategy
5. **PRP Generation** - Complete implementation blueprint with validation gates

##### Execute PRP (`/execute-prp`)
Automated implementation from PRP documents:

```bash
# Execute implementation plan
/execute-prp PRPs/user-authentication-system.md

# Execute with custom configuration
/execute-prp my-feature.md --prp-dir ~/Documents/PRPs
```

**Execution Process**:
1. **Load PRP** - Parse requirements and context
2. **Implementation Planning** - Task breakdown with TodoWrite
3. **Code Generation** - Following patterns and best practices
4. **Validation** - Automated testing and verification
5. **Quality Assurance** - Final validation and cleanup

##### Configure Storage (`/config-prp-storage`)
Manage PRP and research directories:

```bash
# Set custom base directory
/config-prp-storage --base-dir ~/my-claude-workspace

# Set directories individually
/config-prp-storage --prp-dir ~/Documents/PRPs --research-dir ~/Documents/research

# View current configuration
/config-prp-storage --show

# Reset to defaults
/config-prp-storage --reset
```

#### Workflow Example

```bash
# 1. Generate comprehensive implementation plan
/generate-prp "implement real-time chat system with WebSocket support"

# 2. Review generated PRP in PRPs/ directory
# The PRP will include:
# - Complete feature specification
# - Research findings (WebSocket docs, best practices)
# - Implementation strategy
# - Validation gates

# 3. Execute the implementation
/execute-prp PRPs/real-time-chat-system.md

# 4. System automatically:
# - Creates all necessary files
# - Implements features following patterns
# - Runs tests and validation
# - Provides completion report
```

### Code Review & Analysis Commands

#### Merge Review (`/merge_review`)

Generate comprehensive documentation comparing changes between branches with deep architectural analysis.

**Command Syntax**:
```bash
/merge_review <branch-name>
```

**Examples**:
```bash
# Compare current branch with beta
/merge_review beta

# Compare current branch with main
/merge_review main

# Compare with feature branch
/merge_review feature/auth-system
```

**What It Does**:
The merge_review command performs multi-agent analysis of code changes between your current branch and a target branch, generating a comprehensive markdown report that includes:

1. **Complete Diff Analysis** - All code additions, deletions, and modifications
2. **Change Rationale** - Reasoning and justification for each significant change
3. **Documentation References** - Links to official documentation explaining patterns and approaches used
4. **Mermaid Diagrams** - Visual representations of:
   - Architecture changes (before/after)
   - Component relationships
   - Data flow modifications
   - Logic flow changes
   - Refactoring patterns
5. **Impact Assessment** - Risk analysis, breaking changes, testing requirements
6. **Architectural Analysis** - Component changes, design pattern implementations
7. **Performance & Security** - Performance implications and security considerations
8. **Migration Guide** - Steps for developers and operations teams

**Output Location**:
All merge review reports are automatically saved to:
```
/Users/brunoviola/Documents/LaTeX/LaTeXLogBook/Projects/Genomics/documents/markdown/
```

Filename format: `merge-review-{current-branch}-vs-{target-branch}-{timestamp}.md`

**Report Sections**:
- Executive Summary with key changes and impact assessment
- Detailed change analysis (new/modified/deleted files)
- Architectural changes with visual diagrams
- Logic flow modifications
- Refactoring patterns applied
- Data flow changes
- Dependency analysis (new/updated/removed)
- Configuration changes
- Testing implications
- Performance and security considerations
- Documentation references with official sources
- Migration guide
- Complete commit history

**Use Cases**:
- **Pre-merge Review** - Understand all changes before merging
- **Team Communication** - Share comprehensive change documentation
- **Knowledge Transfer** - Document complex refactorings
- **Audit Trail** - Create detailed records of significant changes
- **Architecture Review** - Assess architectural impact of changes

**Multi-Agent Analysis**:
The command uses 5 specialized agents:
1. Diff Analyzer - Categorizes and metrics changes
2. Architectural Impact Analyzer - Identifies pattern and structure changes
3. Logic Flow Analyzer - Tracks algorithm and control flow modifications
4. Documentation Context Researcher - Gathers official documentation references
5. Comprehensive Report Generator - Synthesizes all analysis into markdown

### Configuration Management

#### Storage Configuration

The system uses a flexible directory configuration system:

**Priority Order**:
1. Command-line arguments (`--prp-dir`, `--research-dir`, `--base-dir`)
2. Environment variables (`CLAUDE_PRP_DIR`, `CLAUDE_RESEARCH_DIR`) 
3. Configuration file (`~/.claude/config/prp-storage.conf`)
4. Default fallback (current working directory)

**Configuration File Location**: `~/.claude/config/prp-storage.conf`

#### Environment Variables

```bash
# Set custom directories
export CLAUDE_PRP_DIR="~/Documents/PRPs"
export CLAUDE_RESEARCH_DIR="~/Documents/research"
export DEBUG=true  # Enable debug logging
export LOG_DIR="~/.claude/logs"  # Custom log directory
```

---

## 🏗️ System Architecture

### Enhanced Multi-Agent Architecture

```
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│   Agent 1   │ │   Agent 2   │ │   Agent 3   │
│ (Analysis)  │ │(Complexity) │ │ (Patterns)  │
└─────────────┘ └─────────────┘ └─────────────┘
       │               │               │
       └───────────────┴───────────────┘
                       │
              ┌──────────────┐
              │  Synthesis   │
              │    Agent     │ ← Logging System
              └──────────────┘
                       │
       ┌───────────────┼───────────────┐
       │               │               │
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│   Fix/Impl  │ │   Fix/Impl  │ │   Fix/Impl  │
│   Agent 1   │ │   Agent 2   │ │   Agent 3   │
└─────────────┘ └─────────────┘ └─────────────┘
       │               │               │
       └───────────────┴───────────────┘
                       │
              ┌──────────────┐
              │ Verification │ ← PRP Validation
              │    Agent     │
              └──────────────┘
```

### System Components

#### 1. Multi-Agent Commands
- **Purpose**: Specialized task execution with domain expertise
- **Orchestration**: Coordinated parallel and sequential processing
- **Communication**: Structured result sharing and synthesis

#### 2. Logging Infrastructure  
- **Real-time Monitoring**: Live execution tracking and performance metrics
- **Debug Support**: Comprehensive error tracking and diagnostic information
- **Analytics**: Usage patterns, success rates, and optimization insights

#### 3. PRP Planning System
- **Research Engine**: Automated documentation gathering and analysis
- **Pattern Recognition**: Existing codebase convention detection
- **Implementation Planning**: ULTRATHINK methodology with validation gates

#### 4. Configuration Management
- **Flexible Storage**: Customizable directory structures
- **Environment Integration**: Support for various development workflows
- **Persistence**: Stored configuration across sessions

### Communication Patterns

- **Sequential Orchestration**: Pipeline processing for dependent tasks
- **Concurrent Orchestration**: Parallel analysis from multiple perspectives  
- **Synthesis Coordination**: Result aggregation and decision making
- **Validation Loops**: Quality assurance and error correction

---

## 📚 Command Reference

### Global Options

All commands support these global options:
- `--dry-run` - Show what would be done without executing
- `--verbose` - Enable detailed output
- `--config [file]` - Use custom configuration file
- `--help` - Show command help

### Configuration Files

Most commands support configuration files for customization:

```javascript
// .techdebt.config.js
module.exports = {
  thresholds: {
    maxFileLines: 300,
    maxFunctionLines: 30,
    maxComplexity: 10
  },
  ignore: ['vendor/', 'legacy/'],
  testCommand: "npm test && npm run lint"
};
```

---

## 🔧 Advanced Usage

### CI/CD Integration

Add to your pipeline for automated code quality:

```yaml
# GitHub Actions example
name: Code Quality Analysis
on: [push, pull_request]

jobs:
  code-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Install Claude Subagents
        run: |
          git clone https://github.com/bruvio/claude-subagent-commands.git
          cd claude-subagent-commands
          ./install-globally.sh
          
      - name: Architecture Review
        run: @architecture-review --detect-violations
        
      - name: Tech Debt Analysis  
        run: @tech-debt-finder-fixer --dry-run
        
      - name: Archive Logs
        uses: actions/upload-artifact@v2
        with:
          name: analysis-logs
          path: ~/.claude/logs/
```

### Shell Aliases for Productivity

```bash
# Add to ~/.bashrc or ~/.zshrc
alias sa-logs='~/.claude/commands/log-viewer.sh'
alias sa-stats='~/.claude/commands/log-viewer.sh --stats'
alias sa-errors='~/.claude/commands/log-viewer.sh --errors'
alias sa-clean='~/.claude/commands/log-viewer.sh --clean'
alias sa-follow='~/.claude/commands/log-viewer.sh --follow'

# Quick command aliases
alias debt-check='@tech-debt-finder-fixer --dry-run'
alias arch-check='@architecture-review'
alias perf-check='@perf-optimize --dry-run'
```

### Performance Expectations

| Operation | Time Range | Resource Usage |
|-----------|------------|----------------|
| Simple commands (help, config) | 1-3 seconds | Minimal |
| Code analysis (single file) | 5-15 seconds | Low |
| Complex analysis (full project) | 30-180 seconds | Medium |
| Full tech debt scan | 2-15 minutes | Medium-High |
| Large migration operations | 10-60 minutes | High |
| Log queries | Near-instant | Minimal |

### Real-World Integration Examples

#### Development Workflow Integration

```bash
# Pre-commit workflow
@tech-debt-finder-fixer src/ --auto-fix safe
@test-gen src/ --only-untested
@architecture-review --detect-violations

# Daily maintenance  
@perf-optimize . --baseline yesterday.json
sa-stats | grep -E "(errors|warnings)"
sa-clean 7  # Clean logs older than 7 days
```

#### Project Onboarding

```bash
# New team member setup
/generate-prp "analyze existing codebase and create onboarding documentation"
/execute-prp PRPs/codebase-onboarding.md

# Architecture documentation
@architecture-review --visualize --output documentation/
```

---

## 🚨 Troubleshooting

### Common Issues

#### Installation Problems

**Issue**: Permission denied errors during installation
**Solution**: 
```bash
chmod +x ~/.claude/commands/*.sh
sudo chown -R $USER ~/.claude/
./install-globally.sh
```

**Issue**: Commands not found after installation
**Solution**: 
```bash
# Re-run installation
./install-globally.sh

# Verify PATH configuration
echo $PATH | grep .claude
source ~/.bashrc  # or ~/.zshrc
```

**Issue**: Claude Code not recognizing commands
**Solution**:
```bash
# Verify Claude Code installation
claude --version

# Check command registration
ls -la ~/.claude/commands/
```

#### Command Execution Issues

**Issue**: Logging system not working
**Solution**:
```bash
# Check logging system installation
ls -la ~/.claude/commands/logging-system.sh

# Verify log directory
mkdir -p ~/.claude/logs
chmod 755 ~/.claude/logs

# Test logging system
~/.claude/commands/command-wrapper.sh --help
```

**Issue**: Commands hanging or not responding
**Solution**:
```bash
# Check for background processes
ps aux | grep claude

# View live logs for debugging
~/.claude/commands/log-viewer.sh --follow --errors

# Enable debug mode
export DEBUG=true
```

**Issue**: PRP commands not working
**Solution**:
```bash
# Check PRP configuration
/config-prp-storage --show

# Verify directories exist
mkdir -p PRPs research

# Test PRP system
/generate-prp --help
```

#### Performance Issues

**Issue**: Commands running slowly
**Solution**:
```bash
# Check system resources
top -p $(pgrep -f claude)

# Analyze performance logs
sa-logs --grep "Command completed" | grep "seconds"

# Clear old logs
sa-clean
```

### Debug Mode

Enable comprehensive debugging:

```bash
# Enable debug logging
export DEBUG=true

# Run command with verbose output
@tech-debt-finder-fixer src/ --verbose

# View debug logs
sa-logs --grep "DEBUG" --recent 50
```

### Log Analysis for Troubleshooting

```bash
# Find recent errors
sa-logs --errors --recent 20

# Command-specific issues
sa-logs --command tech-debt-finder-fixer --errors

# Performance analysis
sa-logs --grep "Command completed" | grep -o 'in [0-9]* seconds' | sort -n

# Daily usage patterns
sa-logs --grep "Command started" | cut -d' ' -f1-2 | sort | uniq -c
```

### Getting Help

- **GitHub Issues**: [Report bugs and request features](https://github.com/bruvio/claude-subagent-commands/issues)
- **Documentation**: Complete documentation available in this repository
- **Logging**: Use comprehensive logging system for debugging: `sa-logs --help`
- **Community**: Join discussions and get support from other users

---

## 💡 Best Practices

### Development Workflow

1. **Start with Analysis**: Run commands in dry-run mode first
   ```bash
   @tech-debt-finder-fixer --dry-run
   @architecture-review --detect-violations
   ```

2. **Use Interactive Mode**: Review changes before applying
   ```bash
   @refactor src/component.tsx  # Review proposed changes
   ```

3. **Maintain Good Test Coverage**: Ensure tests before major refactoring
   ```bash
   @test-gen src/ --coverage-target 80
   ```

4. **Work Incrementally**: Fix issues in small batches
   ```bash
   @tech-debt-finder-fixer src/ --fix-order quick-wins --max-fixes 5
   ```

5. **Monitor Progress**: Track improvements over time
   ```bash
   sa-stats  # Regular performance monitoring
   ```

6. **Customize for Your Project**: Define project-specific standards
   ```bash
   # Create .techdebt.config.js with your thresholds
   ```

### Logging Best Practices

1. **Regular Monitoring**: Check logs regularly for patterns
   ```bash
   sa-logs --stats  # Weekly review
   ```

2. **Log Cleanup**: Prevent disk space issues
   ```bash
   sa-clean 30  # Keep 30 days of logs
   ```

3. **Performance Tracking**: Monitor command execution times
   ```bash
   sa-logs --grep "Command completed" --recent 50
   ```

4. **Error Analysis**: Review error patterns for workflow improvements
   ```bash
   sa-errors | head -20
   ```

### PRP System Best Practices

1. **Comprehensive Planning**: Use PRP system for complex features
   ```bash
   /generate-prp "implement OAuth authentication system"
   ```

2. **Review Before Execution**: Always review generated PRPs
   ```bash
   # Review PRPs/oauth-authentication.md before executing
   ```

3. **Iterative Development**: Use PRP for incremental improvements
   ```bash
   /generate-prp "add rate limiting to existing API endpoints"
   ```

### Security Considerations

- **Log Sensitivity**: Logs may contain file paths and command arguments
- **Regular Cleanup**: Use `sa-clean` to remove old logs
- **Review Before Sharing**: Check logs before exporting or sharing
- **Retention Policies**: Consider organizational requirements for log retention
- **Access Control**: Ensure proper permissions on `~/.claude/` directory

---

## 🏗️ Key Features

- **Parallel Processing**: Multiple agents work simultaneously for comprehensive analysis
- **Specialized Expertise**: Each agent focuses on its domain with deep knowledge
- **Comprehensive Analysis**: No aspect of code quality is overlooked
- **Intelligent Coordination**: Agents share findings for optimal decision-making
- **Safe Implementation**: All changes verified through automated testing
- **Scalable Architecture**: Efficiently handles projects of any size
- **Complete Observability**: Comprehensive logging and monitoring
- **Advanced Planning**: PRP system for complex feature development

---

## 🤝 Contributing

### Getting Started

1. **Development Setup**:
   ```bash
   git clone https://github.com/bruvio/claude-subagent-commands.git
   cd claude-subagent-commands
   ./install-globally.sh
   ```

2. **Create New Commands**: Follow existing patterns in `sub-agent-*.md` files
3. **Testing**: Ensure all examples work and commands are properly documented
4. **Documentation**: Update README for new features

### Command Development Patterns

Key principles for creating new multi-agent commands:
- **Clear Agent Roles**: Each agent should have a specific, well-defined purpose
- **Structured Communication**: Define clear interfaces between agents
- **Progressive Enhancement**: Build complex behaviors from simple agents
- **Safety First**: Always include validation, testing, and rollback capabilities
- **User Control**: Provide dry-run and interactive modes for all operations

### Code of Conduct

This project follows a collaborative, respectful development environment. Contributions should:
- Follow existing code and documentation patterns
- Include comprehensive testing and validation
- Maintain backward compatibility
- Provide clear documentation and examples

---

## 📝 License

This collection is provided as reference implementations for Claude sub-agent orchestration patterns.

---

## 📊 Performance Metrics

- **Installation Time**: < 2 minutes
- **Command Response**: 1-10 seconds for simple operations
- **Analysis Operations**: 30 seconds - 10 minutes depending on scope
- **Logging Overhead**: < 1% performance impact
- **Storage Efficiency**: Configurable log retention with automated cleanup

---


