# Install Claude Settings

Install the default project awareness CLAUDE.md file in a new repository.

## Command: install-claude-settings

## Arguments: [target_directory]

## Process

1. **Validate Target Directory**
   - Check if target directory exists
   - Ensure it's a valid directory path
   - Default to current directory if no argument provided

2. **Check Existing CLAUDE.md**
   - If CLAUDE.md already exists, ask user for confirmation to overwrite
   - Backup existing file if user confirms overwrite

3. **Install CLAUDE.md**
   - Copy the default CLAUDE.md template to target directory
   - Set appropriate permissions
   - Confirm successful installation

4. **Validate Installation**
   - Verify file was copied successfully
   - Check file contents are intact
   - Report installation status

## Usage Examples

```bash
# Install in current directory
/install-claude-settings

# Install in specific directory
/install-claude-settings /path/to/project

# Install in relative directory
/install-claude-settings ./my-project
```

## Implementation

The command will:
- Use the CLAUDE.md file from the global commands directory as template
- Handle file conflicts gracefully
- Provide clear feedback to user
- Ensure proper file permissions