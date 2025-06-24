# Claude Subagent Commands Collection

A comprehensive collection of powerful sub-agent orchestration commands for Claude that demonstrate how to coordinate multiple specialized AI agents to tackle complex software engineering tasks.

## 🚀 Quick Installation

```bash
# Clone and install globally
git clone https://github.com/Dreamrealai/claude-subagent-commands.git
cd claude-subagent-commands
chmod +x install-globally.sh
./install-globally.sh
```

## 📋 Available Commands

### 1. Tech Debt Finder & Fixer
**Aliases:** `@tech-debt-finder-fixer`, `@td-finder-fixer`, `@satdff`

A two-phase command that identifies and fixes technical debt:
- **Phase 1:** 5 parallel agents analyze code for duplicates, complexity, patterns, dead code, and type coverage
- **Phase 2:** Specialized fix agents safely refactor code with automated testing

```bash
# Find and fix tech debt with review
@tech-debt-finder-fixer

# Quick wins only - safe fixes
@tech-debt-finder-fixer --auto-fix safe --fix-order quick-wins

# Dry run to see what would be fixed
@tech-debt-finder-fixer --dry-run
```

### 2. Architecture Reviewer
**Aliases:** `@architecture-review`, `@arch-review`, `@saar`

Analyzes system architecture and generates visual documentation:
- Dependency mapping and circular dependency detection
- Pattern analysis (MVC, Hexagonal, DDD compliance)
- Complexity metrics and cognitive load assessment
- Generates Mermaid/PlantUML diagrams

```bash
# Basic architecture review
@architecture-review

# Full analysis with violations
@arch-review src/ --detect-violations --suggest-improvements

# Generate diagrams for specific style
@architecture-review --style hexagonal --visualize --output mermaid
```

### 3. Test Generator
**Aliases:** `@test-gen`, `@test-generator`, `@satg`

Generates comprehensive test suites by analyzing code:
- Coverage analysis to find untested paths
- Code path analysis for behavior mapping
- Pattern recognition for consistent test style
- Parallel generation of unit, integration, and E2E tests

```bash
# Generate missing unit tests
@test-gen src/services/ --only-untested

# Generate tests with 90% coverage target
@test-gen src/ --coverage-target 90 --type unit

# Generate E2E tests from user flows
@test-gen --type e2e --from-flows src/features/
```

### 4. Performance Optimizer
**Aliases:** `@perf-optimize`, `@performance`, `@sapo`

Full-stack performance optimization across all layers:
- Frontend bundle analysis and React optimization
- Backend API and query optimization
- Database index and schema optimization
- Caching strategy development

```bash
# Frontend bundle optimization
@perf-optimize src/ --target frontend --bundle-analysis

# Database query optimization
@perf-optimize --target database --suggest-indexes

# Full stack optimization
@performance . --baseline perf-baseline.json
```

### 5. Migration Assistant
**Aliases:** `@migrate`, `@migration-assistant`, `@sama`

Assists with framework and library migrations:
- Deprecation scanning and compatibility analysis
- Pattern detection and migration planning
- Automated codemod execution
- Incremental migration with rollback support

**Supported Migrations:**
- React 16→17→18, Class→Hooks
- Laravel 8→9→10
- JavaScript→TypeScript
- Database version upgrades

```bash
# React version migration
@migrate --from react@17 --to react@18 --safe-mode

# Pattern migration
@migrate --pattern class-to-hooks src/components/

# Laravel upgrade
@migrate --from laravel@8 --to laravel@10 --incremental
```

### 6. Intelligent Refactor
**Aliases:** `@refactor`, `@sar`

Intelligently refactors code while maintaining functionality:
- Extracts methods and components
- Reduces complexity and splits large files
- Consolidates duplicate utilities
- Standardizes patterns across codebase
- Full test verification after each change

```bash
# Auto-detect and refactor
@refactor src/components/UserDashboard.tsx

# Extract repeated code into shared utilities
@refactor src/pages/ --type extract-method --create-shared

# Reduce function complexity
@refactor src/utils/ --type reduce-complexity --max-function-size 20
```

### 7. New Feature Builder
**Aliases:** `@new-feature`, `@sanf`

Builds new features by learning from your existing code:
- Analyzes existing patterns and conventions
- Maximizes code reuse
- Checks for existing packages
- Generates complete, working features
- Creates tests alongside implementation

```bash
# Add a user profile component
@new-feature --feature "User profile card with avatar, name, and stats" --location src/components/

# Full-stack feature with tests
@new-feature \
  --feature "Comment system with real-time updates" \
  --location src/features/comments \
  --type full-stack \
  --test-first
```

## 🏗️ Multi-Agent Architecture

All commands follow a similar pattern of specialized agent orchestration:

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
              │    Agent     │
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
              │ Verification │
              │    Agent     │
              └──────────────┘
```

## 🔧 Configuration

Most commands support configuration files:

```javascript
// .techdebt.config.js
module.exports = {
  thresholds: {
    maxFileLines: 300,
    maxFunctionLines: 30,
    maxComplexity: 10
  },
  ignore: ['vendor/', 'legacy/']
};
```

## 🚀 CI/CD Integration

Add to your pipeline for automated code quality:

```yaml
# Example GitHub Action
code-quality:
  script:
    - @architecture-review --detect-violations
    - @tech-debt-finder-fixer --dry-run
```

## 💡 Best Practices

1. **Start with Analysis:** Run commands in dry-run mode first
2. **Use Interactive Mode:** Review changes before applying
3. **Have Good Tests:** Ensure test coverage before major refactoring
4. **Work Incrementally:** Fix issues in small batches
5. **Monitor Progress:** Track improvements over time
6. **Customize Rules:** Define project-specific standards

## 🌟 Key Features

- **Parallel Processing:** Multiple agents work simultaneously
- **Specialized Expertise:** Each agent focuses on its domain
- **Comprehensive Analysis:** No aspect is overlooked
- **Intelligent Coordination:** Agents share findings for better decisions
- **Safe Implementation:** Changes are verified at each step
- **Scalable:** Can handle large codebases efficiently

## 📚 Documentation

Each command includes comprehensive documentation with:
- Detailed parameter explanations
- Usage examples from basic to advanced
- Agent orchestration patterns
- Configuration options
- Error handling guides
- Framework-specific notes

## 🤝 Contributing

These examples demonstrate patterns for creating your own multi-agent commands. Key principles:
- **Clear Agent Roles:** Each agent should have a specific purpose
- **Structured Communication:** Define clear interfaces between agents
- **Progressive Enhancement:** Build complex behaviors from simple agents
- **Safety First:** Always include verification and rollback
- **User Control:** Provide dry-run and interactive modes

## 📝 License

This collection is provided as reference implementations for Claude sub-agent orchestration patterns.

---

*Generated with Claude Sub-Agent commands for maximum productivity and code quality.*