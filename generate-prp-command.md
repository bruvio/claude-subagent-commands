# Generate PRP Command

Generate a comprehensive Product Requirements and Planning (PRP) document for feature implementation.

## Command: generate-prp

## Arguments: [feature_description_file] [options]

Options:
- `--prp-dir [directory]` - Override PRP storage directory
- `--research-dir [directory]` - Override research storage directory
- `--base-dir [directory]` - Override base directory for both PRP and research

## Process

0. **Directory Configuration**
   - Load PRP storage configuration from `$HOME/.claude/config/prp-storage.conf`
   - Apply command-line directory overrides if provided
   - Fall back to environment variables if available
   - Use current working directory as final fallback
   - Create configured directories if they don't exist
   - Validate directory permissions for read/write access

1. **Feature Analysis**
   - Read and understand the feature description file
   - Identify core requirements and objectives
   - Determine scope and complexity
   - Extract any specific constraints or preferences

2. **Comprehensive Research**
   - Perform in-depth codebase analysis
   - Search for similar features and patterns
   - Research external documentation (30-100 pages minimum)
   - Study official documentation pages only
   - Create detailed research files in configured research directory
   - Document all findings with references

3. **Codebase Pattern Analysis**
   - Identify existing conventions and patterns
   - Locate relevant files and components
   - Understand current architecture
   - Note testing patterns and validation approaches
   - Document integration points

4. **External Research Deep Dive**
   - Research library documentation with specific URLs
   - Find implementation examples and best practices
   - Identify common pitfalls and gotchas
   - Collect comprehensive code examples
   - Document version-specific considerations

5. **ULTRATHINK Planning**
   - Synthesize all research findings
   - Design comprehensive implementation approach
   - Plan validation and testing strategy
   - Consider error handling and edge cases
   - Create detailed implementation blueprint

6. **PRP Generation**
   - Use configured PRP directory with templates/prp_base.md as template
   - Include all critical context and documentation URLs
   - Provide comprehensive code examples
   - Define executable validation gates
   - Create step-by-step implementation tasks
   - Include references to research files in configured research directory

7. **Quality Assurance**
   - Validate PRP completeness (1-10 confidence score)
   - Ensure all context is included for one-pass implementation
   - Verify validation gates are executable
   - Check references to existing patterns
   - Confirm clear implementation path

## Usage Examples

```bash
# Generate PRP from feature file (uses configured directories)
/generate-prp features/user-dashboard.md

# Generate PRP with custom base directory
/generate-prp features/user-dashboard.md --base-dir ~/my-prp-workspace

# Generate PRP with custom PRP and research directories
/generate-prp requirements/api-integration.txt --prp-dir ~/Documents/PRPs --research-dir ~/Documents/research

# Generate PRP from specification (uses configured directories)
/generate-prp specs/authentication-system.md
```

## Research Process Requirements

- **Minimum 30-100 pages** of documentation research
- **Official documentation only** - no assumptions from AI knowledge
- **Comprehensive code examples** in research files
- **Working production-ready examples** documented
- **Version-specific model names** researched and documented
- **All research saved** in organized configured research directory structure

## Output Structure

- **Save as**: `{configured-prp-dir}/{project-name}.md`
- **Include**: All necessary context for AI agent implementation
- **Provide**: Executable validation commands
- **Reference**: Existing codebase patterns
- **Document**: Clear implementation path with error handling

## Quality Standards

The generated PRP must enable one-pass implementation success through:
- Comprehensive context inclusion
- Executable validation gates
- Clear pattern references
- Detailed implementation steps
- Error handling documentation
- Complete research integration

## Research Directory Structure

```
{configured-research-dir}/
├── {technology-name}/
│   ├── official-docs-page1.md
│   ├── official-docs-page2.md
│   ├── examples-and-patterns.md
│   └── model-specifications.md
└── {another-technology}/
    ├── api-documentation.md
    └── implementation-examples.md
```

## Directory Configuration

The system automatically loads directory configuration in this priority order:
1. Command-line arguments (`--prp-dir`, `--research-dir`, `--base-dir`)
2. Environment variables (`CLAUDE_PRP_DIR`, `CLAUDE_RESEARCH_DIR`, `CLAUDE_PRP_BASE_DIR`)
3. Configuration file (`$HOME/.claude/config/prp-storage.conf`)
4. Default fallback (current working directory: `./PRPs`, `./research`)

Use `/config-prp-storage` command to set up persistent directory configuration.