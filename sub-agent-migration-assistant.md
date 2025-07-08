# Sub-Agent Migration Assistant Command

A comprehensive multi-agent system that orchestrates framework and library migrations through automated analysis, planning, and execution with safety checks and rollback capabilities.

## Command Syntax

```bash
sub-agent-migration-assistant [target] [options]

# Aliases
@migrate [target] [options]
@migration-assistant [target] [options]
@sama [target] [options]
```

## Parameters

### Core Options
- `target` - Directory to migrate (defaults to current directory)
- `--from` - Source framework/version (e.g., react@17, laravel@8)
- `--to` - Target framework/version (e.g., react@18, laravel@10)
- `--pattern` - Migration pattern type (class-to-hooks, js-to-ts, etc.)
- `--type` - Migration type (version, pattern, framework, database)

### Migration Control
- `--safe-mode` - Enable enhanced safety checks (default: true)
- `--incremental` - Enable incremental migration approach
- `--dry-run` - Show migration plan without executing
- `--interactive` - Review each migration step (default: true)
- `--auto-approve` - Auto-approve low-risk migrations
- `--rollback-point` - Create rollback checkpoints

### Execution Options
- `--backup` - Create full backup before migration (default: true)
- `--test-command` - Command to run tests between steps
- `--verify-command` - Command to verify migration success
- `--parallel` - Run compatible migrations in parallel
- `--max-batch-size` - Maximum files per migration batch

### Framework-Specific
- `--preserve-behavior` - Maintain exact behavior (default: true)
- `--update-dependencies` - Update related dependencies
- `--fix-breaking-changes` - Auto-fix known breaking changes
- `--generate-compatibility` - Generate compatibility layers

## Examples

### Basic Migrations
```bash
# React version migration
@migrate --from react@17 --to react@18 --safe-mode

# Pattern migration
@migrate --pattern class-to-hooks src/components/

# Laravel upgrade
@migrate --from laravel@8 --to laravel@10 --incremental

# JavaScript to TypeScript
@migrate --pattern js-to-ts src/ --preserve-behavior
```

### Advanced Migrations
```bash
# Full-stack React migration with dependency updates
@migrate src/ \
  --from react@16 \
  --to react@18 \
  --update-dependencies \
  --fix-breaking-changes \
  --test-command "npm test && npm run e2e"

# Incremental Laravel migration with checkpoints
@migrate \
  --from laravel@8 \
  --to laravel@10 \
  --incremental \
  --rollback-point \
  --verify-command "php artisan test"

# Complex pattern migration
@migrate app/ \
  --pattern class-to-hooks \
  --parallel \
  --max-batch-size 5 \
  --generate-compatibility
```

### Database Migrations
```bash
# MySQL version upgrade
@migrate --type database \
  --from mysql@5.7 \
  --to mysql@8.0 \
  --backup \
  --verify-command "php artisan migrate:status"

# PostgreSQL schema migration
@migrate database/ \
  --from postgresql@12 \
  --to postgresql@15 \
  --incremental \
  --rollback-point
```

## Supported Migration Types

### Framework Migrations
- **React**: 16→17→18, Class→Hooks, Legacy→Modern
- **Laravel**: 8→9→10, Eloquent upgrades
- **Angular**: Version upgrades, AngularJS→Angular
- **Vue**: 2→3, Options→Composition API
- **Node.js**: Version upgrades, CommonJS→ESM

### Pattern Migrations
- **React**: Class components → Hooks, HOCs → Hooks
- **JavaScript**: Callbacks → Promises → Async/Await
- **CSS**: CSS → Styled Components → CSS Modules
- **State Management**: Redux → Context API → Zustand

### Language Migrations
- **JavaScript → TypeScript**: Full type coverage
- **Python**: 2→3, Legacy syntax modernization
- **PHP**: Version upgrades, modern syntax adoption

### Database Migrations
- **Version Upgrades**: MySQL, PostgreSQL, MongoDB
- **Schema Changes**: Table restructuring, index optimization
- **Query Modernization**: Legacy → Modern SQL patterns

## Stage 1: Migration Analysis (Parallel Agents)

### Agent 1: Compatibility Analyzer
```
Analyze compatibility between source and target in [TARGET]

Analysis Tasks:
1. Dependency Compatibility:
   - Check all package versions
   - Identify incompatible dependencies
   - Find alternative packages
   - Calculate upgrade complexity
   - Map transitive dependencies

2. API Compatibility:
   - Deprecated API usage
   - Breaking changes catalog
   - Removed features identification
   - New API opportunities
   - Migration path mapping

3. Feature Compatibility:
   - Feature parity analysis
   - Behavior differences
   - Performance implications
   - Security considerations
   - Browser/platform support

4. Breaking Changes:
   - Syntax changes required
   - Configuration updates
   - Runtime behavior changes
   - Build process modifications
   - Testing framework updates

Return:
- Compatibility report
- Breaking changes list
- Migration complexity score
- Risk assessment
- Recommended migration path
```

### Agent 2: Deprecation Scanner
```
Scan for deprecated patterns and APIs in [TARGET]

Scanning Tasks:
1. Deprecated APIs:
   - Framework API deprecations
   - Library method deprecations
   - Configuration deprecations
   - Plugin API changes
   - Build tool deprecations

2. Outdated Patterns:
   - Old syntax patterns
   - Legacy architecture patterns
   - Deprecated design patterns
   - Obsolete configurations
   - Outdated conventions

3. Security Vulnerabilities:
   - Known security issues
   - Vulnerable dependencies
   - Insecure patterns
   - Outdated security practices
   - Compliance violations

4. Performance Issues:
   - Slow deprecated methods
   - Inefficient patterns
   - Memory leaks
   - Bundle size impacts
   - Runtime performance

Return:
- Deprecation locations
- Severity ratings
- Replacement suggestions
- Migration priorities
- Timeline recommendations
```

### Agent 3: Pattern Detector
```
Detect migration patterns in [TARGET]

Pattern Detection:
1. Code Patterns:
   - Class component patterns
   - Function component patterns
   - Hook usage patterns
   - State management patterns
   - Event handling patterns

2. Architecture Patterns:
   - MVC implementations
   - Service layer patterns
   - Repository patterns
   - Factory patterns
   - Observer patterns

3. Data Patterns:
   - Database query patterns
   - API call patterns
   - Data transformation patterns
   - Caching patterns
   - Validation patterns

4. Testing Patterns:
   - Test structure patterns
   - Mocking patterns
   - Assertion patterns
   - Setup/teardown patterns
   - Integration test patterns

Return:
- Pattern inventory
- Conversion mappings
- Migration complexity
- Automation potential
- Manual review requirements
```

### Agent 4: Dependency Mapper
```
Map all dependencies and their migration requirements in [TARGET]

Mapping Tasks:
1. Direct Dependencies:
   - Package.json analysis
   - Composer.json analysis
   - Requirements.txt analysis
   - Gemfile analysis
   - Build dependencies

2. Transitive Dependencies:
   - Dependency tree analysis
   - Version conflict detection
   - Peer dependency issues
   - Optional dependency handling
   - Dev dependency cleanup

3. Internal Dependencies:
   - Module dependencies
   - Component dependencies
   - Service dependencies
   - Utility dependencies
   - Configuration dependencies

4. External Dependencies:
   - API dependencies
   - Database dependencies
   - Third-party services
   - CDN dependencies
   - Plugin dependencies

Return:
- Dependency graph
- Update requirements
- Conflict resolutions
- Migration ordering
- Risk assessment
```

### Agent 5: Test Coverage Analyzer
```
Analyze test coverage for migration safety in [TARGET]

Coverage Analysis:
1. Test Coverage:
   - Unit test coverage
   - Integration test coverage
   - E2E test coverage
   - Component test coverage
   - API test coverage

2. Critical Path Coverage:
   - Core functionality tests
   - Edge case coverage
   - Error handling tests
   - Performance tests
   - Security tests

3. Migration-Specific Tests:
   - Behavior preservation tests
   - Compatibility tests
   - Regression tests
   - Migration validation tests
   - Rollback tests

4. Test Quality:
   - Test maintainability
   - Test reliability
   - Test execution time
   - Test isolation
   - Test documentation

Return:
- Coverage report
- Critical gaps
- Test recommendations
- Safety score
- Migration readiness
```

## Synthesis & Planning Agent

```
Synthesize all analysis results and create migration plan: [ALL_ANALYSIS]

Planning Tasks:
1. Risk Assessment:
   - High-risk components
   - Breaking change impacts
   - Rollback complexity
   - Timeline risks
   - Resource requirements

2. Migration Strategy:
   - Incremental vs big-bang
   - Parallel vs sequential
   - Feature flagging needs
   - Compatibility layers
   - Rollback strategy

3. Execution Plan:
   - Step-by-step procedures
   - Dependency ordering
   - Batch sizing
   - Checkpoint creation
   - Verification points

4. Contingency Planning:
   - Failure scenarios
   - Rollback procedures
   - Alternative approaches
   - Emergency protocols
   - Recovery plans

Generate:
- Migration roadmap
- Risk mitigation plan
- Resource allocation
- Timeline estimates
- Success metrics
```

### Example Migration Plan Output
```
🔄 Migration Plan: React 17 → React 18
=======================================

📊 Analysis Summary
- Files to migrate: 247
- Breaking changes: 12
- Estimated time: 8-12 hours
- Risk level: Medium
- Success probability: 95%

🎯 Migration Strategy: Incremental
Phase 1: Dependencies (2 hours)
- Update React core packages
- Update related dependencies
- Fix peer dependency conflicts

Phase 2: Breaking Changes (4 hours)
- Replace ReactDOM.render with createRoot
- Update React.FC types
- Fix StrictMode warnings
- Update testing utilities

Phase 3: Optimizations (2 hours)
- Implement automatic batching
- Add concurrent features
- Optimize re-renders

🔧 Execution Plan:
1. [SAFE] Create backup branch
2. [SAFE] Update package.json
3. [MEDIUM] Fix breaking changes
4. [MEDIUM] Update component patterns
5. [REVIEW] Optimize performance

🚨 Risk Mitigation:
- Comprehensive test suite required
- Staged rollout recommended
- Monitoring alerts configured
- Rollback plan prepared

Proceed with migration? [Y/n]:
```

## Stage 2: Migration Execution

### Pre-Migration Agent
```
Prepare system for migration:

1. Environment Check:
   - Git status clean
   - All tests passing
   - Build succeeds
   - Dependencies installed
   - Backup created

2. Safety Setup:
   - Create backup branch
   - Document current state
   - Set up monitoring
   - Prepare rollback scripts
   - Configure alerts

3. Migration Setup:
   - Install migration tools
   - Configure automation
   - Set up test environment
   - Prepare verification
   - Initialize logging

Return: Go/No-go decision
```

### Migration Orchestrator
```
Coordinate migration execution: [MIGRATION_PLAN]

Orchestration Tasks:
1. Batch Processing:
   - Group related changes
   - Order by dependencies
   - Manage parallel execution
   - Monitor progress
   - Handle failures

2. Checkpoint Management:
   - Create rollback points
   - Validate checkpoints
   - Document state
   - Test rollback procedures
   - Maintain history

3. Progress Tracking:
   - Monitor execution
   - Report progress
   - Track metrics
   - Handle blockers
   - Adjust timeline

For each migration step:
- Execute migration
- Run verification
- Create checkpoint
- Update progress
- Handle errors
```

### Specialized Migration Agents (Parallel)

#### Agent M1: Dependency Migrator
```
Migrate package dependencies: [DEPENDENCIES_TO_MIGRATE]

Tasks:
1. Package Updates:
   - Update package versions
   - Resolve version conflicts
   - Handle peer dependencies
   - Update lock files
   - Verify installations

2. Configuration Updates:
   - Update config files
   - Migrate settings
   - Update build configs
   - Fix path references
   - Update scripts

3. Import Updates:
   - Update import statements
   - Fix module paths
   - Handle renamed exports
   - Update type imports
   - Clean unused imports

Requirements:
- Maintain functionality
- Preserve configurations
- Update all references
- Verify compatibility
```

#### Agent M2: Code Pattern Migrator
```
Migrate code patterns: [PATTERNS_TO_MIGRATE]

Tasks:
1. Syntax Migration:
   - Convert class to functional
   - Update lifecycle methods
   - Migrate state management
   - Convert event handlers
   - Update prop handling

2. API Migration:
   - Replace deprecated APIs
   - Update method signatures
   - Migrate configuration
   - Handle breaking changes
   - Add compatibility layers

3. Pattern Modernization:
   - Apply modern patterns
   - Improve performance
   - Enhance readability
   - Add type safety
   - Follow best practices

Requirements:
- Preserve behavior
- Maintain performance
- Update all instances
- Add proper types
```

#### Agent M3: Configuration Migrator
```
Migrate configuration files: [CONFIGS_TO_MIGRATE]

Tasks:
1. Config File Updates:
   - Update syntax
   - Migrate settings
   - Fix deprecated options
   - Add new configurations
   - Remove obsolete settings

2. Build Configuration:
   - Update build tools
   - Migrate webpack configs
   - Update scripts
   - Fix plugins
   - Update loaders

3. Environment Configuration:
   - Update environment files
   - Migrate CI/CD configs
   - Update deployment configs
   - Fix environment variables
   - Update documentation

Requirements:
- Maintain build process
- Preserve environments
- Update all references
- Test configurations
```

#### Agent M4: Test Migrator
```
Migrate test files: [TESTS_TO_MIGRATE]

Tasks:
1. Test Framework Updates:
   - Update test utilities
   - Migrate test APIs
   - Fix test configurations
   - Update assertions
   - Handle async changes

2. Test Pattern Updates:
   - Update component tests
   - Migrate mocking patterns
   - Fix setup/teardown
   - Update snapshots
   - Handle timing issues

3. Test Environment:
   - Update test configs
   - Migrate test data
   - Fix test utilities
   - Update CI tests
   - Handle environments

Requirements:
- Maintain test coverage
- Preserve test behavior
- Update all test files
- Verify test execution
```

#### Agent M5: Documentation Migrator
```
Update documentation: [DOCS_TO_MIGRATE]

Tasks:
1. API Documentation:
   - Update API references
   - Fix code examples
   - Update usage patterns
   - Add migration notes
   - Update troubleshooting

2. Code Documentation:
   - Update inline comments
   - Fix JSDoc/PHPDoc
   - Update README files
   - Fix code examples
   - Update architecture docs

3. User Documentation:
   - Update user guides
   - Fix installation docs
   - Update tutorials
   - Add migration guide
   - Update FAQ

Requirements:
- Maintain accuracy
- Update all references
- Fix broken links
- Verify examples
```

### Verification Agent
```
Verify migration success:

1. Functional Verification:
   - All tests passing
   - Build succeeds
   - Runtime behavior correct
   - Performance maintained
   - Security preserved

2. Integration Verification:
   - API compatibility
   - Database connections
   - Third-party integrations
   - Environment compatibility
   - Cross-browser testing

3. Quality Verification:
   - Code quality maintained
   - Documentation updated
   - Type safety preserved
   - Performance benchmarks
   - Security audit

4. Rollback Verification:
   - Rollback scripts tested
   - Backup integrity verified
   - Recovery procedures validated
   - Monitoring functional
   - Alerts configured

Generate migration report with:
- Success metrics
- Issues encountered
- Performance impact
- Recommendations
- Next steps
```

## Framework-Specific Migration Strategies

### React Migration Strategy
```
React 16 → 17 → 18 Migration Pattern:

1. Version 16 → 17:
   - Update React packages
   - Fix event delegation changes
   - Update TypeScript types
   - Fix development warnings
   - Test compatibility

2. Version 17 → 18:
   - Replace ReactDOM.render
   - Update concurrent features
   - Fix StrictMode issues
   - Update testing utilities
   - Implement new features

3. Class → Hooks:
   - Convert lifecycle methods
   - Migrate state management
   - Update event handlers
   - Convert higher-order components
   - Update testing patterns
```

### Laravel Migration Strategy
```
Laravel 8 → 9 → 10 Migration Pattern:

1. Version 8 → 9:
   - Update PHP version
   - Fix breaking changes
   - Update Eloquent models
   - Migrate configurations
   - Update dependencies

2. Version 9 → 10:
   - Update PHP requirements
   - Fix deprecations
   - Update service providers
   - Migrate middleware
   - Update testing

3. Pattern Modernization:
   - Use modern Eloquent
   - Implement new features
   - Update API patterns
   - Improve performance
   - Add type hints
```

### JavaScript → TypeScript Strategy
```
JS → TS Migration Pattern:

1. Initial Setup:
   - Install TypeScript
   - Configure tsconfig.json
   - Set up build process
   - Add type definitions
   - Configure IDE

2. Incremental Migration:
   - Rename .js to .ts
   - Add basic types
   - Fix type errors
   - Add strict types
   - Improve type safety

3. Advanced Types:
   - Generic types
   - Utility types
   - Conditional types
   - Mapped types
   - Type guards
```

## Error Handling & Rollback

### Error Detection
```
Monitor for migration errors:

1. Compilation Errors:
   - Syntax errors
   - Type errors
   - Import errors
   - Configuration errors
   - Build failures

2. Runtime Errors:
   - Functionality breaks
   - Performance regressions
   - Integration failures
   - API incompatibilities
   - Database errors

3. Test Failures:
   - Unit test failures
   - Integration test failures
   - E2E test failures
   - Performance test failures
   - Security test failures
```

### Rollback Procedures
```
Automated rollback process:

1. Immediate Rollback:
   - Stop migration process
   - Restore from backup
   - Revert configuration
   - Restore dependencies
   - Verify functionality

2. Partial Rollback:
   - Identify failure point
   - Rollback to checkpoint
   - Preserve successful changes
   - Fix specific issues
   - Resume migration

3. Full Rollback:
   - Complete system restore
   - Restore all files
   - Restore dependencies
   - Restore configurations
   - Restore database
```

### Recovery Strategies
```
Recovery from migration failures:

1. Automated Recovery:
   - Retry failed steps
   - Apply fixes automatically
   - Skip problematic files
   - Continue with remaining
   - Report issues

2. Manual Recovery:
   - Identify root cause
   - Apply manual fixes
   - Test solutions
   - Resume automation
   - Document lessons

3. Alternative Approaches:
   - Try different strategy
   - Use compatibility layers
   - Implement workarounds
   - Defer problematic items
   - Gradual migration
```

## Configuration Options

### Migration Configuration
```yaml
# .migration.config.yaml
migration:
  strategy: incremental
  safety_mode: true
  backup: true
  parallel: false
  
batch:
  max_size: 10
  timeout: 300
  
verification:
  test_command: "npm test"
  build_command: "npm run build"
  lint_command: "npm run lint"
  
rollback:
  auto_rollback: true
  checkpoint_frequency: 5
  max_rollback_attempts: 3
  
notifications:
  email: admin@example.com
  slack: "#migrations"
  webhook: "https://api.example.com/webhook"
```

### Framework-Specific Config
```javascript
// react.migration.js
module.exports = {
  react: {
    version: {
      from: "17.0.0",
      to: "18.0.0"
    },
    breaking_changes: {
      react_dom_render: true,
      concurrent_features: true,
      strict_mode: true
    },
    compatibility: {
      generate_polyfills: true,
      maintain_legacy_api: false
    }
  }
};
```

## Safety Features

### Pre-Migration Safety
- Clean git status verification
- Comprehensive test suite requirement
- Backup creation and verification
- Environment compatibility check
- Dependency conflict detection

### During Migration Safety
- Incremental step execution
- Checkpoint creation and validation
- Continuous testing between steps
- Progress monitoring and alerts
- Automatic error detection

### Post-Migration Safety
- Full functionality verification
- Performance benchmark comparison
- Security audit execution
- Documentation update verification
- Rollback procedure testing

## Integration

### CI/CD Integration
```yaml
# .github/workflows/migration.yml
name: Migration Pipeline
on:
  push:
    branches: [migration/*]

jobs:
  migrate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Migration
        run: |
          @migrate --dry-run
          @migrate --auto-approve safe
      - name: Verify Migration
        run: |
          npm test
          npm run build
          npm run e2e
```

### IDE Integration
```json
{
  "commands": [
    {
      "command": "claude.migrate",
      "title": "Migrate Framework",
      "category": "Migration"
    }
  ]
}
```

### Monitoring Integration
```javascript
// monitoring.js
const migration = require('./migration-assistant');

migration.on('progress', (data) => {
  console.log(`Migration progress: ${data.percent}%`);
  metrics.gauge('migration.progress', data.percent);
});

migration.on('error', (error) => {
  console.error('Migration error:', error);
  alerts.send('migration-error', error);
});
```

## Best Practices

### Migration Planning
1. **Thorough Analysis**: Complete compatibility and deprecation analysis
2. **Incremental Approach**: Migrate in small, manageable steps
3. **Safety First**: Always create backups and rollback plans
4. **Test Coverage**: Ensure comprehensive test coverage before migration
5. **Documentation**: Document migration process and decisions

### Execution Best Practices
1. **Start Small**: Begin with low-risk components
2. **Monitor Progress**: Track migration progress and metrics
3. **Validate Continuously**: Test after each migration step
4. **Handle Errors**: Have robust error handling and recovery
5. **Communicate**: Keep stakeholders informed of progress

### Post-Migration Best Practices
1. **Comprehensive Testing**: Run full test suite including E2E tests
2. **Performance Monitoring**: Monitor for performance regressions
3. **Documentation Update**: Update all relevant documentation
4. **Knowledge Sharing**: Share lessons learned with team
5. **Continuous Improvement**: Refine migration process for future use

## Success Metrics

### Migration Success
- **Completion Rate**: Percentage of successful migrations
- **Time to Completion**: Actual vs estimated migration time
- **Error Rate**: Number of errors encountered during migration
- **Rollback Rate**: Percentage of migrations requiring rollback
- **Test Coverage**: Maintained or improved test coverage

### Quality Metrics
- **Performance Impact**: Performance before vs after migration
- **Code Quality**: Code quality metrics before vs after
- **Type Safety**: Type coverage improvement (for TypeScript migrations)
- **Security**: Security vulnerability reduction
- **Maintainability**: Code maintainability improvement

### Business Impact
- **Developer Productivity**: Time savings in development
- **Bug Reduction**: Reduction in production bugs
- **Technical Debt**: Reduction in technical debt
- **Team Satisfaction**: Developer satisfaction with migration process
- **Long-term Benefits**: Measured benefits over time