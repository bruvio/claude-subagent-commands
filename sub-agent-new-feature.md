# New Feature Builder Subagent

## Command Definition
**Primary Command:** `@new-feature`  
**Aliases:** `@sanf` (Subagent New Feature)

The New Feature Builder is a sophisticated multi-agent orchestration system that builds complete, working features by learning from your existing codebase patterns and conventions. It maximizes code reuse, follows established architectural patterns, and generates comprehensive implementations with tests.

## Multi-Agent Orchestration Pattern

The New Feature Builder coordinates multiple specialized agents in a sequential workflow:

1. **Code Pattern Analyzer** - Analyzes existing code patterns and conventions
2. **Architecture Planner** - Designs feature structure based on existing patterns
3. **Dependency Checker** - Identifies existing packages and utilities to reuse
4. **Feature Generator** - Generates the actual feature implementation
5. **Test Generator** - Creates comprehensive test suites
6. **Integration Validator** - Ensures proper integration with existing code

## Parameters

### Core Parameters
- `--feature` (required): Description of the feature to build
- `--location` (required): Target directory for the feature implementation
- `--type`: Feature type (`frontend`, `backend`, `full-stack`, `component`, `api`, `service`)
- `--test-first`: Generate tests before implementation (TDD approach)

### Advanced Parameters
- `--framework`: Specific framework to target (`react`, `vue`, `angular`, `express`, `fastapi`, etc.)
- `--pattern`: Architectural pattern to follow (`mvc`, `mvvm`, `clean`, `hexagonal`)
- `--reuse-only`: Only use existing components and utilities (no new dependencies)
- `--style`: Styling approach (`css-modules`, `styled-components`, `tailwind`, `scss`)
- `--state`: State management approach (`redux`, `zustand`, `context`, `mobx`)
- `--db`: Database integration (`prisma`, `sequelize`, `mongoose`, `typeorm`)

### Configuration Parameters
- `--config`: Path to feature generation configuration file
- `--template`: Use specific feature template
- `--dry-run`: Show what would be generated without creating files
- `--interactive`: Interactive mode for step-by-step confirmation

## Usage Examples

### Basic Feature Generation
```bash
# Simple component with basic functionality
@new-feature --feature "User profile card with avatar, name, and stats" --location src/components/

# API endpoint with validation
@new-feature --feature "User authentication endpoint" --location src/api/auth/ --type backend
```

### Advanced Feature Building
```bash
# Full-stack feature with specific framework
@new-feature \
  --feature "Comment system with real-time updates" \
  --location src/features/comments \
  --type full-stack \
  --framework react \
  --state redux \
  --test-first

# Component with specific styling approach
@new-feature \
  --feature "Dashboard chart widget with data visualization" \
  --location src/components/charts \
  --type component \
  --style styled-components \
  --reuse-only
```

### Test-Driven Development
```bash
# Generate tests first, then implementation
@new-feature \
  --feature "Shopping cart with add/remove/update functionality" \
  --location src/features/cart \
  --test-first \
  --pattern clean

# Interactive mode for complex features
@new-feature \
  --feature "Multi-step form wizard with validation" \
  --location src/components/forms \
  --interactive \
  --dry-run
```

### Database Integration
```bash
# Feature with database operations
@new-feature \
  --feature "Product catalog with search and filtering" \
  --location src/features/products \
  --type full-stack \
  --db prisma \
  --framework next

# API service with data validation
@new-feature \
  --feature "User notification system" \
  --location src/services/notifications \
  --type backend \
  --db mongoose \
  --framework express
```

## Agent Coordination Workflow

### Phase 1: Pattern Analysis
```
Code Pattern Analyzer:
├── Scan existing codebase for patterns
├── Identify architectural conventions
├── Extract reusable components and utilities
├── Analyze naming conventions and file structure
└── Generate pattern report
```

### Phase 2: Architecture Planning
```
Architecture Planner:
├── Design feature structure based on patterns
├── Plan component hierarchy and relationships
├── Define data flow and state management
├── Create integration points with existing code
└── Generate architecture blueprint
```

### Phase 3: Dependency Management
```
Dependency Checker:
├── Identify existing packages that can be reused
├── Check for compatible utilities and helpers
├── Validate framework compatibility
├── Suggest new dependencies if needed
└── Generate dependency plan
```

### Phase 4: Feature Generation
```
Feature Generator:
├── Generate core feature implementation
├── Create component files and logic
├── Implement API endpoints (if backend)
├── Add styling and UI components
├── Generate configuration files
└── Create integration code
```

### Phase 5: Test Generation
```
Test Generator:
├── Generate unit tests for components
├── Create integration tests for workflows
├── Add API endpoint tests (if backend)
├── Generate mock data and fixtures
├── Create test utilities and helpers
└── Generate test configuration
```

### Phase 6: Integration Validation
```
Integration Validator:
├── Validate imports and dependencies
├── Check type compatibility
├── Verify routing and navigation
├── Validate state management integration
├── Check styling consistency
└── Generate integration report
```

## Configuration Options

### Feature Configuration File (.new-feature.json)
```json
{
  "defaultFramework": "react",
  "defaultType": "component",
  "testFramework": "jest",
  "styleSystem": "tailwind",
  "stateManagement": "zustand",
  "patterns": {
    "component": "functional",
    "api": "restful",
    "database": "repository"
  },
  "conventions": {
    "naming": "camelCase",
    "files": "kebab-case",
    "folders": "kebab-case"
  },
  "templates": {
    "component": "./templates/component.tsx",
    "api": "./templates/api.ts",
    "test": "./templates/test.tsx"
  }
}
```

### Framework-Specific Configuration
```json
{
  "frameworks": {
    "react": {
      "componentPattern": "functional",
      "stateManagement": "hooks",
      "testingLibrary": "@testing-library/react",
      "styleSystem": "styled-components"
    },
    "vue": {
      "componentPattern": "composition",
      "stateManagement": "pinia",
      "testingLibrary": "@vue/test-utils",
      "styleSystem": "scoped"
    },
    "angular": {
      "componentPattern": "class",
      "stateManagement": "ngrx",
      "testingLibrary": "jasmine",
      "styleSystem": "scss"
    }
  }
}
```

## Error Handling and Validation

### Pre-Generation Validation
```bash
# Validate feature requirements
@new-feature --feature "User dashboard" --location src/invalid-path/ --dry-run
# Error: Location 'src/invalid-path/' does not exist

# Check for conflicting features
@new-feature --feature "Login form" --location src/components/auth/
# Warning: Similar component 'LoginComponent' already exists
```

### Generation Error Handling
```bash
# Handle missing dependencies
@new-feature --feature "Chart component" --location src/components/
# Error: Required dependency 'chart.js' not found. Install? (y/n)

# Handle framework conflicts
@new-feature --feature "React component" --framework vue --location src/
# Error: Framework mismatch. Project uses React but Vue specified
```

### Post-Generation Validation
```bash
# Validate generated code
@new-feature --feature "API service" --location src/api/ --validate
# Success: Generated code passes linting and type checking
# Warning: Generated tests need manual review for business logic
```

## Test Generation Strategies

### Test-First Development
```bash
# Generate comprehensive test suite first
@new-feature \
  --feature "User registration with email verification" \
  --location src/features/auth \
  --test-first \
  --framework react

# Generated test structure:
# ├── UserRegistration.test.tsx
# ├── EmailVerification.test.tsx
# ├── __mocks__/
# │   ├── authService.ts
# │   └── emailService.ts
# └── __fixtures__/
#     ├── userData.ts
#     └── emailTemplates.ts
```

### Test Types Generated
- **Unit Tests**: Individual component and function testing
- **Integration Tests**: Feature workflow testing
- **API Tests**: Endpoint validation and error handling
- **E2E Tests**: Complete user journey testing
- **Performance Tests**: Load and stress testing (for backend features)

## Framework-Specific Feature Building

### React Features
```bash
# React component with hooks and context
@new-feature \
  --feature "Product search with filters" \
  --location src/components/search \
  --framework react \
  --state context \
  --style styled-components
```

### Vue Features
```bash
# Vue component with composition API
@new-feature \
  --feature "Image gallery with lazy loading" \
  --location src/components/gallery \
  --framework vue \
  --state pinia \
  --style scoped
```

### Angular Features
```bash
# Angular service with dependency injection
@new-feature \
  --feature "Data synchronization service" \
  --location src/services/sync \
  --framework angular \
  --type service \
  --pattern injectable
```

### Backend Features
```bash
# Express API with middleware
@new-feature \
  --feature "File upload with validation" \
  --location src/api/upload \
  --framework express \
  --type backend \
  --db mongodb
```

## Advanced Usage Patterns

### Multi-Step Feature Building
```bash
# Build complex features in stages
@new-feature \
  --feature "E-commerce checkout process" \
  --location src/features/checkout \
  --type full-stack \
  --interactive \
  --stages "cart-review,payment-processing,order-confirmation"
```

### Micro-Frontend Architecture
```bash
# Build self-contained micro-frontend
@new-feature \
  --feature "User dashboard micro-frontend" \
  --location src/micro-frontends/dashboard \
  --pattern micro-frontend \
  --framework react \
  --build-config webpack
```

### Feature Flags Integration
```bash
# Feature with built-in feature flags
@new-feature \
  --feature "Beta analytics dashboard" \
  --location src/features/analytics \
  --feature-flags launchdarkly \
  --rollout-strategy percentage
```

## Best Practices

1. **Pattern Consistency**: Always analyze existing patterns before generation
2. **Code Reuse**: Maximize reuse of existing components and utilities
3. **Test Coverage**: Generate comprehensive tests for all generated code
4. **Documentation**: Include inline documentation and usage examples
5. **Type Safety**: Generate TypeScript types and interfaces
6. **Error Boundaries**: Include proper error handling and validation
7. **Performance**: Consider performance implications and optimizations
8. **Accessibility**: Include accessibility features and ARIA labels

## Integration with Development Workflow

### Pre-commit Integration
```bash
# Validate generated features before commit
@new-feature --feature "Contact form" --location src/forms/ --pre-commit-check
```

### CI/CD Integration
```bash
# Generate features as part of CI pipeline
@new-feature --feature "API endpoint" --location src/api/ --ci-mode --no-interactive
```

### Team Collaboration
```bash
# Generate features with team review process
@new-feature --feature "User settings" --location src/features/ --review-mode --assign-reviewer
```

The New Feature Builder subagent represents the next evolution in AI-assisted development, combining pattern recognition, code generation, and intelligent orchestration to build complete, production-ready features that seamlessly integrate with your existing codebase.