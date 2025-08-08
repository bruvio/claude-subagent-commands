# Execute PRP Command

Execute a Product Requirements and Planning (PRP) document to implement a feature.

## Command: execute-prp

## Arguments: [prp_file_path]

## Process

1. **Load PRP File**
   - Read the specified PRP file
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
# Execute a specific PRP file
/execute-prp PRPs/user-dashboard.md

# Execute PRP in current directory
/execute-prp ./feature-requirements.md

# Execute PRP with relative path
/execute-prp ../PRPs/api-integration.md
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