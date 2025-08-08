# Generate PRP Command

Generate a comprehensive Product Requirements and Planning (PRP) document for feature implementation.

## Command: generate-prp

## Arguments: [feature_description_file]

## Process

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
   - Create detailed research files in /research/ directory
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
   - Use PRPs/templates/prp_base.md as template
   - Include all critical context and documentation URLs
   - Provide comprehensive code examples
   - Define executable validation gates
   - Create step-by-step implementation tasks
   - Include references to research files

7. **Quality Assurance**
   - Validate PRP completeness (1-10 confidence score)
   - Ensure all context is included for one-pass implementation
   - Verify validation gates are executable
   - Check references to existing patterns
   - Confirm clear implementation path

## Usage Examples

```bash
# Generate PRP from feature file
/generate-prp features/user-dashboard.md

# Generate PRP from requirements
/generate-prp requirements/api-integration.txt

# Generate PRP from specification
/generate-prp specs/authentication-system.md
```

## Research Process Requirements

- **Minimum 30-100 pages** of documentation research
- **Official documentation only** - no assumptions from AI knowledge
- **Comprehensive code examples** in research files
- **Working production-ready examples** documented
- **Version-specific model names** researched and documented
- **All research saved** in organized /research/ directory structure

## Output Structure

- **Save as**: `PRPs/{project-name}.md`
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
/research/
├── {technology-name}/
│   ├── official-docs-page1.md
│   ├── official-docs-page2.md
│   ├── examples-and-patterns.md
│   └── model-specifications.md
└── {another-technology}/
    ├── api-documentation.md
    └── implementation-examples.md
```