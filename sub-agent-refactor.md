# Sub-Agent Intelligent Refactor Command

A comprehensive refactoring command that intelligently improves code structure while maintaining functionality through coordinated multi-agent analysis and implementation.

## Command Syntax

```bash
sub-agent-refactor [target] [options]

# Aliases
@refactor [target] [options]
@sar [target] [options]
```

## Parameters

### Target
- `target` - File, directory, or glob pattern to refactor (defaults to current directory)

### Options
- `--type` - Refactoring type (extract-method, extract-component, reduce-complexity, consolidate-utils, standardize-patterns, auto-detect)
- `--create-shared` - Create shared utility files when extracting
- `--max-function-size` - Maximum function size in lines (default: 30)
- `--max-file-size` - Maximum file size in lines (default: 300)
- `--max-complexity` - Maximum cyclomatic complexity (default: 10)
- `--preserve-behavior` - Ensure behavior preservation (default: true)
- `--test-first` - Run tests before each refactor (default: true)
- `--interactive` - Review each refactor before applying (default: true)
- `--dry-run` - Show what would be refactored without making changes
- `--framework` - Framework-specific refactoring (react, vue, angular, laravel, wordpress)
- `--backup` - Create backups before refactoring (default: true)
- `--parallel` - Run compatible refactors in parallel (default: false)
- `--ignore` - Patterns to ignore (.refactorignore file)

## Examples

### Basic Usage
```bash
# Auto-detect and refactor
@refactor src/components/UserDashboard.tsx

# Extract repeated code into shared utilities
@refactor src/pages/ --type extract-method --create-shared

# Reduce function complexity
@refactor src/utils/ --type reduce-complexity --max-function-size 20
```

### Advanced Usage
```bash
# Framework-specific React refactoring
@refactor src/components/ \
  --framework react \
  --type extract-component \
  --max-file-size 200

# Consolidate utilities across the project
@refactor src/ \
  --type consolidate-utils \
  --create-shared \
  --interactive true

# Comprehensive refactoring with custom limits
@refactor . \
  --type auto-detect \
  --max-function-size 25 \
  --max-complexity 8 \
  --preserve-behavior true \
  --test-first true

# Pattern standardization
@refactor src/ \
  --type standardize-patterns \
  --framework react \
  --dry-run
```

## Phase 1: Analysis Agents (Parallel)

### Agent 1: Structure Analyzer
```
Analyze code structure in [TARGET]

Structure Analysis Tasks:
1. Function Analysis:
   - Function length and complexity
   - Parameter count and types
   - Return value complexity
   - Single responsibility violations
   - Nested function depth

2. Component Analysis:
   - Component size and props
   - State management complexity
   - Hook usage patterns
   - Render method complexity
   - Component responsibilities

3. Class Analysis:
   - Method count and complexity
   - Property organization
   - Inheritance depth
   - Interface compliance
   - Cohesion metrics

4. File Analysis:
   - File size and structure
   - Export/import patterns
   - Module responsibilities
   - Dependency count
   - Logical groupings

Return:
- Complexity hotspots
- Extraction opportunities
- Split candidates
- Method extraction points
- Component decomposition suggestions
```

### Agent 2: Pattern Detector
```
Detect refactoring patterns in [TARGET]

Pattern Detection Tasks:
1. Code Duplication:
   - Identical code blocks
   - Similar algorithms
   - Repeated patterns
   - Copy-paste violations
   - Near-duplicate utilities

2. Design Patterns:
   - Missing abstractions
   - Strategy pattern opportunities
   - Factory pattern candidates
   - Observer pattern potential
   - Command pattern possibilities

3. Framework Patterns:
   - React: Hook extraction, component splitting
   - Vue: Composable opportunities
   - Angular: Service extraction
   - Laravel: Service provider patterns
   - WordPress: Plugin patterns

4. Architectural Patterns:
   - Repository pattern opportunities
   - Service layer extractions
   - Facade pattern candidates
   - Adapter pattern needs
   - Decorator pattern potential

Return:
- Pattern implementation opportunities
- Refactoring strategy recommendations
- Framework-specific suggestions
- Architectural improvements
- Code organization enhancements
```

### Agent 3: Dependency Analyzer
```
Analyze dependencies and coupling in [TARGET]

Dependency Analysis Tasks:
1. Coupling Analysis:
   - Tight coupling identification
   - Dependency injection opportunities
   - Interface extraction points
   - Circular dependency detection
   - Coupling reduction strategies

2. Cohesion Analysis:
   - Related functionality groups
   - Logical module boundaries
   - Responsibility alignment
   - Feature cohesion metrics
   - Splitting opportunities

3. Import/Export Analysis:
   - Unused imports
   - Barrel export opportunities
   - Re-export patterns
   - Module organization
   - Dependency optimization

4. External Dependencies:
   - Third-party library usage
   - Abstraction layer needs
   - Wrapper opportunities
   - Version compatibility
   - Alternative suggestions

Return:
- Coupling reduction opportunities
- Cohesion improvement suggestions
- Module reorganization plans
- Dependency optimization strategies
- Interface extraction recommendations
```

### Agent 4: Complexity Assessor
```
Assess complexity and maintainability in [TARGET]

Complexity Assessment Tasks:
1. Cyclomatic Complexity:
   - Function complexity metrics
   - Decision point analysis
   - Path complexity assessment
   - Simplification opportunities
   - Conditional logic refactoring

2. Cognitive Complexity:
   - Understanding difficulty
   - Mental model complexity
   - Nesting depth issues
   - Variable scope problems
   - Logic flow clarity

3. Maintainability Index:
   - Code maintainability score
   - Documentation completeness
   - Testing coverage impact
   - Change impact analysis
   - Refactoring priorities

4. Technical Debt:
   - Code smell identification
   - Refactoring urgency
   - Maintenance cost analysis
   - Quality improvement potential
   - Risk assessment

Return:
- Complexity reduction strategies
- Simplification priorities
- Maintainability improvements
- Technical debt remediation
- Quality enhancement opportunities
```

## Phase 2: Synthesis Agent

```
Synthesize refactoring analysis from all agents: [ALL_ANALYSIS_RESULTS]
Create comprehensive refactoring plan with prioritization.

Synthesis Tasks:
1. Opportunity Categorization:
   - Group related refactoring opportunities
   - Identify dependencies between refactors
   - Categorize by complexity and impact
   - Prioritize by business value
   - Assess implementation effort

2. Risk Assessment:
   - Behavior preservation analysis
   - Breaking change potential
   - Test coverage evaluation
   - Performance impact assessment
   - Integration risk evaluation

3. Implementation Strategy:
   - Refactoring order planning
   - Parallel execution opportunities
   - Rollback strategy definition
   - Testing approach design
   - Verification criteria

4. Resource Planning:
   - Time estimation
   - Skill requirements
   - Tool recommendations
   - Documentation needs
   - Team coordination

Generate:
- Prioritized refactoring roadmap
- Risk mitigation strategies
- Implementation guidelines
- Success metrics
- Rollback procedures
```

### Example Synthesis Output
```
🔄 Intelligent Refactor Analysis Complete
==========================================

📊 Refactoring Opportunities Summary
- Total Opportunities: 45
- Estimated Improvement Time: 18 hours
- Complexity Reduction: 35%
- Maintainability Gain: +42%

🎯 High-Impact Refactors (6 hours)
1. Extract UserProfileCard from UserDashboard.tsx → 3 reusable components
2. Consolidate 8 date utility functions → 1 shared utility module
3. Split OrderService.ts (420 lines) → 3 focused services
4. Extract validation logic → reusable validation framework

⚡ Quick Wins (2 hours)
1. Extract 12 repeated API patterns → service layer
2. Consolidate 6 similar React hooks → 2 generic hooks
3. Extract 15 inline styles → styled components
4. Simplify 8 complex conditional chains

🏗️ Structural Improvements (10 hours)
1. Decompose ProductCatalog component → 5 focused components
2. Extract business logic from controllers → service layer
3. Refactor authentication module → hexagonal architecture
4. Consolidate error handling → centralized error management

📈 Recommended Execution Order:
1. [SAFE] Extract utility functions and constants
2. [SAFE] Consolidate duplicate code patterns
3. [MEDIUM] Split large components and files
4. [MEDIUM] Extract business logic to services
5. [REVIEW] Refactor architectural patterns

Proceed with refactoring? [Y/n]:
```

## Phase 3: Refactoring Implementation Agents

### Pre-Refactor Validation Agent
```
Validate system readiness for refactoring:

Validation Tasks:
1. Environment Check:
   - Git status is clean
   - All tests passing
   - Build succeeds
   - Dependencies up to date

2. Coverage Analysis:
   - Test coverage assessment
   - Critical path testing
   - Edge case coverage
   - Integration test validation

3. Backup Preparation:
   - Create backup branch
   - Document current state
   - Prepare rollback strategy
   - Set up monitoring

4. Tool Verification:
   - Refactoring tool availability
   - Code formatter configuration
   - Linter setup validation
   - Test runner verification

Return: Go/No-go decision with specific blockers
```

### Refactor Orchestrator Agent
```
Coordinate refactoring execution based on approved plan: [REFACTOR_PLAN]

Orchestration Tasks:
1. Execution Planning:
   - Order refactors by dependency
   - Identify parallel opportunities
   - Set up progress tracking
   - Configure rollback points

2. Agent Coordination:
   - Assign refactors to specialized agents
   - Monitor progress and conflicts
   - Coordinate shared resource usage
   - Manage inter-agent communication

3. Quality Assurance:
   - Verify each refactor completion
   - Run incremental tests
   - Validate behavior preservation
   - Check code quality metrics

4. Progress Management:
   - Track completion status
   - Report progress to user
   - Handle errors and rollbacks
   - Maintain audit trail

For each refactor:
- Execute atomic operation
- Verify behavior preservation
- Run targeted tests
- Commit incrementally
- Update progress tracking
```

### Specialized Refactoring Agents (Parallel)

#### Agent R1: Method Extractor
```
Extract methods and functions: [EXTRACTION_TARGETS]

Method Extraction Tasks:
1. Function Analysis:
   - Identify extraction boundaries
   - Analyze parameter dependencies
   - Determine return values
   - Assess side effects
   - Plan naming conventions

2. Code Extraction:
   - Extract logical code blocks
   - Parameterize dependencies
   - Handle scope issues
   - Maintain functionality
   - Preserve error handling

3. Integration:
   - Replace extracted code with calls
   - Update imports/exports
   - Fix type definitions
   - Maintain interfaces
   - Update documentation

4. Optimization:
   - Optimize parameter passing
   - Improve function signatures
   - Add type annotations
   - Enhance readability
   - Follow conventions

Requirements:
- Preserve exact behavior
- Maintain performance
- Follow naming conventions
- Update all references
- Add appropriate tests
```

#### Agent R2: Component Splitter
```
Split large components and files: [SPLIT_TARGETS]

Component Splitting Tasks:
1. Boundary Analysis:
   - Identify logical boundaries
   - Analyze prop dependencies
   - Determine state ownership
   - Plan component hierarchy
   - Assess reusability

2. Component Extraction:
   - Extract sub-components
   - Manage prop passing
   - Handle state distribution
   - Maintain event handling
   - Preserve styling

3. File Organization:
   - Create appropriate files
   - Organize folder structure
   - Update index files
   - Manage imports/exports
   - Follow conventions

4. Integration Testing:
   - Verify component integration
   - Test prop passing
   - Validate state management
   - Check event handling
   - Ensure styling consistency

Requirements:
- Maintain component behavior
- Preserve user experience
- Follow architecture patterns
- Update all references
- Maintain test coverage
```

#### Agent R3: Utility Consolidator
```
Consolidate duplicate utilities: [CONSOLIDATION_TARGETS]

Utility Consolidation Tasks:
1. Duplicate Analysis:
   - Identify similar utilities
   - Analyze functional differences
   - Determine common interfaces
   - Plan consolidation strategy
   - Assess impact scope

2. Utility Creation:
   - Create consolidated utilities
   - Handle parameter variations
   - Maintain backward compatibility
   - Add comprehensive types
   - Include documentation

3. Migration:
   - Update all references
   - Replace duplicate code
   - Fix import statements
   - Handle edge cases
   - Maintain functionality

4. Optimization:
   - Optimize performance
   - Improve type safety
   - Enhance error handling
   - Add comprehensive tests
   - Follow conventions

Requirements:
- Maintain all functionality
- Preserve performance
- Handle all edge cases
- Update comprehensive tests
- Follow project patterns
```

#### Agent R4: Pattern Standardizer
```
Standardize code patterns: [PATTERN_TARGETS]

Pattern Standardization Tasks:
1. Pattern Analysis:
   - Identify inconsistent patterns
   - Analyze framework conventions
   - Determine standard approach
   - Plan migration strategy
   - Assess breaking changes

2. Pattern Implementation:
   - Apply consistent patterns
   - Update code structures
   - Modernize syntax
   - Follow best practices
   - Maintain compatibility

3. Framework Alignment:
   - Apply framework conventions
   - Use recommended patterns
   - Leverage framework features
   - Optimize for performance
   - Follow documentation

4. Consistency Verification:
   - Check pattern consistency
   - Validate conventions
   - Ensure maintainability
   - Test functionality
   - Document standards

Requirements:
- Maintain functionality
- Follow framework conventions
- Preserve performance
- Update documentation
- Maintain test coverage
```

#### Agent R5: Complexity Reducer
```
Reduce code complexity: [COMPLEXITY_TARGETS]

Complexity Reduction Tasks:
1. Complexity Analysis:
   - Identify complexity sources
   - Analyze decision points
   - Evaluate nesting levels
   - Assess cognitive load
   - Plan simplification

2. Simplification:
   - Reduce nesting depth
   - Simplify conditional logic
   - Extract complex expressions
   - Use early returns
   - Apply guard clauses

3. Logic Refactoring:
   - Break down complex functions
   - Use strategy patterns
   - Implement lookup tables
   - Apply polymorphism
   - Reduce branching

4. Readability Enhancement:
   - Improve variable names
   - Add explanatory comments
   - Create helper functions
   - Organize code flow
   - Follow conventions

Requirements:
- Preserve exact behavior
- Maintain performance
- Improve readability
- Reduce complexity metrics
- Maintain test coverage
```

### Verification Agent
```
Verify refactoring success and quality: [REFACTOR_RESULTS]

Verification Tasks:
1. Behavior Verification:
   - Run comprehensive test suite
   - Verify functionality preservation
   - Check edge cases
   - Validate performance
   - Test error scenarios

2. Code Quality Assessment:
   - Measure complexity reduction
   - Verify pattern consistency
   - Check maintainability metrics
   - Validate code coverage
   - Assess documentation quality

3. Integration Testing:
   - Test component integration
   - Verify API compatibility
   - Check dependency resolution
   - Validate build process
   - Test deployment pipeline

4. Performance Validation:
   - Measure performance impact
   - Check memory usage
   - Validate load times
   - Test scalability
   - Monitor resource usage

Generate:
- Verification report
- Quality metrics comparison
- Performance impact analysis
- Remaining opportunities
- Success recommendations
```

## Framework-Specific Refactoring

### React Refactoring
```javascript
// Before: Large component with mixed concerns
const UserDashboard = () => {
  const [user, setUser] = useState(null);
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  
  // 200+ lines of mixed logic...
};

// After: Extracted components and hooks
const UserDashboard = () => {
  const { user, loading } = useUser();
  const { orders } = useUserOrders(user?.id);
  
  return (
    <DashboardLayout>
      <UserProfile user={user} />
      <OrderHistory orders={orders} />
    </DashboardLayout>
  );
};
```

### Vue Refactoring
```vue
<!-- Before: Large component with mixed concerns -->
<template>
  <div>
    <!-- 100+ lines of template -->
  </div>
</template>

<script>
export default {
  data() {
    return {
      // 50+ reactive properties
    };
  },
  methods: {
    // 30+ methods
  }
};
</script>

<!-- After: Extracted composables and components -->
<template>
  <div>
    <UserProfile :user="user" />
    <OrderHistory :orders="orders" />
  </div>
</template>

<script setup>
import { useUser } from '@/composables/useUser';
import { useOrders } from '@/composables/useOrders';

const { user } = useUser();
const { orders } = useOrders(user);
</script>
```

### Laravel Refactoring
```php
// Before: Fat controller with mixed concerns
class UserController extends Controller
{
    public function show(User $user)
    {
        // 100+ lines of business logic
        // Database queries
        // Data transformation
        // Email sending
        // File processing
    }
}

// After: Extracted services and actions
class UserController extends Controller
{
    public function show(User $user, UserService $userService)
    {
        $userData = $userService->getUserData($user);
        return view('user.show', compact('userData'));
    }
}
```

## Configuration

### .refactorignore
```
# Ignore patterns for refactoring
node_modules/
vendor/
*.min.js
*.generated.ts
legacy/
third-party/
__tests__/
*.test.js
*.spec.ts
```

### .refactor.config.js
```javascript
module.exports = {
  // Complexity thresholds
  complexity: {
    maxFunctionSize: 30,
    maxFileSize: 300,
    maxComplexity: 10,
    maxNestingDepth: 4
  },
  
  // Extraction settings
  extraction: {
    minDuplicateLines: 5,
    minUtilityUsage: 3,
    createSharedUtils: true,
    utilityLocation: 'src/utils'
  },
  
  // Framework-specific settings
  framework: {
    type: 'react',
    componentMaxSize: 200,
    hookExtractionThreshold: 3,
    stateManagementPattern: 'context'
  },
  
  // Testing requirements
  testing: {
    requireTests: true,
    testCommand: 'npm test',
    coverageThreshold: 80,
    testFirst: true
  },
  
  // Safety settings
  safety: {
    createBackups: true,
    requireCleanGit: true,
    preserveBehavior: true,
    incrementalCommits: true
  }
};
```

## Integration Examples

### VS Code Extension
```json
{
  "contributes": {
    "commands": [
      {
        "command": "claude.refactor",
        "title": "Intelligent Refactor"
      }
    ],
    "keybindings": [
      {
        "command": "claude.refactor",
        "key": "ctrl+shift+r",
        "when": "editorTextFocus"
      }
    ]
  }
}
```

### CI/CD Pipeline
```yaml
refactor-check:
  stage: quality
  script:
    - @refactor --dry-run --type auto-detect
    - echo "Refactoring opportunities: $(cat refactor-report.json | jq '.opportunities | length')"
  artifacts:
    reports:
      junit: refactor-report.xml
    paths:
      - refactor-report.json
  only:
    - merge_requests
```

### Git Hook
```bash
#!/bin/bash
# Pre-commit refactoring check
if @refactor --dry-run --quick | grep -q "HIGH PRIORITY"; then
  echo "High priority refactoring opportunities detected"
  echo "Run: @refactor --type auto-detect"
  exit 1
fi
```

## Best Practices

### 1. Incremental Refactoring
- Start with small, safe refactors
- Build confidence with quick wins
- Gradually tackle complex refactors
- Always maintain working software

### 2. Test-Driven Refactoring
- Ensure comprehensive test coverage
- Run tests before each refactor
- Validate behavior preservation
- Add tests for new extractions

### 3. Pattern Consistency
- Follow established project patterns
- Use framework conventions
- Maintain consistent naming
- Document refactoring decisions

### 4. Performance Awareness
- Monitor performance impact
- Avoid over-abstraction
- Consider memory implications
- Test with realistic data

### 5. Team Communication
- Review refactoring plans with team
- Document architectural decisions
- Share extracted utilities
- Coordinate parallel refactors

## Safety Features

### 1. Behavior Preservation
- Comprehensive test execution
- Automated behavior verification
- Performance impact monitoring
- User experience validation

### 2. Rollback Capabilities
- Automatic backup creation
- Incremental commit strategy
- Easy rollback procedures
- State restoration tools

### 3. Quality Assurance
- Code quality metrics tracking
- Pattern consistency verification
- Documentation maintenance
- Integration testing

### 4. Risk Management
- Impact assessment before refactoring
- Gradual implementation strategy
- Continuous monitoring
- Emergency rollback procedures

## Success Metrics

### Code Quality Metrics
- Cyclomatic complexity reduction
- Maintainability index improvement
- Code duplication elimination
- Pattern consistency increase

### Development Metrics
- Development velocity improvement
- Bug rate reduction
- Code review efficiency
- Onboarding time reduction

### Business Metrics
- Feature delivery acceleration
- Maintenance cost reduction
- Team satisfaction improvement
- Technical debt reduction

---

*The Intelligent Refactor command demonstrates advanced multi-agent orchestration for safe, comprehensive code improvement while maintaining functionality and following best practices.*