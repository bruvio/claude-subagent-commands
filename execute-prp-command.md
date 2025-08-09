# Execute PRP Command

Execute a Product Requirements and Planning (PRP) document to implement a feature.

## Command: execute-prp

## Arguments: [prp_file_path] [options]

Options:
- `--prp-dir [directory]` - Override PRP storage directory for relative paths
- `--research-dir [directory]` - Override research storage directory  
- `--base-dir [directory]` - Override base directory for both PRP and research

## Process

0. **Directory Configuration**
   - Load PRP storage configuration from `$HOME/.claude/config/prp-storage.conf`
   - Apply command-line directory overrides if provided
   - Fall back to environment variables if available
   - Use current working directory as final fallback
   - Resolve PRP file path using configured directories if relative

1. **Load PRP File**
   - Read the specified PRP file (resolve path using configured directories if relative)
   - Validate PRP format and structure
   - Extract all requirements and context
   - Ensure understanding of implementation scope

2. **ULTRATHINK Phase**
   - Analyze all PRP requirements thoroughly
   - Break down complex tasks into manageable steps
   - Create comprehensive implementation plan using TodoWrite
   - Identify patterns from existing codebase
   - Plan validation and testing approach

3. **Research & Context Gathering**
   - Follow all research requirements from PRP
   - Gather additional context if needed
   - Explore existing codebase patterns
   - Verify third-party documentation and APIs

4. **Implementation**
   - Execute the implementation plan step by step
   - Follow all coding standards and patterns
   - Implement features according to PRP specifications
   - Create necessary tests and documentation

5. **Validation**
   - Run all validation commands specified in PRP
   - Fix any failures or issues
   - Re-run validation until all tests pass
   - Ensure code quality standards are met

6. **Completion**
   - Verify all PRP requirements are fulfilled
   - Run final validation suite
   - Update project documentation if needed
   - Report completion status with summary

## Usage Examples

```bash
# Execute PRP using configured directories (relative path)
/execute-prp user-dashboard.md

# Execute PRP with absolute path
/execute-prp /full/path/to/feature-requirements.md

# Execute PRP with custom directories
/execute-prp api-integration.md --base-dir ~/my-prp-workspace

# Execute PRP from configured PRP directory (legacy format)
/execute-prp PRPs/user-dashboard.md

# Execute PRP with custom PRP and research directories
/execute-prp my-feature.md --prp-dir ~/Documents/PRPs --research-dir ~/Documents/research
```

## Key Features

- **Comprehensive Planning**: Uses TodoWrite for detailed task tracking
- **Context Awareness**: Leverages existing codebase patterns
- **Validation-Driven**: Ensures all tests pass before completion
- **Research Integration**: Follows documentation and best practices
- **Quality Assurance**: Maintains code standards throughout implementation

## Error Handling

- If PRP file doesn't exist, provide clear error message
- If validation fails, show specific failures and retry guidance
- If implementation blocks occur, provide detailed debugging information
- Maintain detailed logs of execution progress

## Directory Configuration

The system automatically loads directory configuration in this priority order:
1. Command-line arguments (`--prp-dir`, `--research-dir`, `--base-dir`)
2. Environment variables (`CLAUDE_PRP_DIR`, `CLAUDE_RESEARCH_DIR`, `CLAUDE_PRP_BASE_DIR`)
3. Configuration file (`$HOME/.claude/config/prp-storage.conf`)
4. Default fallback (current working directory: `./PRPs`, `./research`)

For relative PRP file paths, the system will first look in the configured PRP directory, then fall back to the current working directory.

Use `/config-prp-storage` command to set up persistent directory configuration.