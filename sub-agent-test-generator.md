# Sub-Agent Test Generator Command

Generates comprehensive test suites by analyzing code coverage, mapping behavior patterns, and orchestrating specialized agents to create unit, integration, and end-to-end tests with consistent style and high coverage.

## Command Syntax

```bash
sub-agent-test-generator [target] [options]

# Aliases
@test-gen [target] [options]
@test-generator [target] [options]
@satg [target] [options]
```

## Parameters

### Target
- `target` - Directory, file, or glob pattern to generate tests for (defaults to current directory)

### Options
- `--type` - Test types to generate (unit, integration, e2e, all)
- `--coverage-target` - Target coverage percentage (default: 80)
- `--only-untested` - Only generate tests for uncovered code
- `--framework` - Testing framework (jest, vitest, cypress, playwright, mocha)
- `--style` - Test style (describe/it, given/when/then, arrange/act/assert)
- `--mocks` - Mock strategy (auto, manual, none)
- `--fixtures` - Generate test fixtures (default: true)
- `--parallel` - Generate tests in parallel (default: true)
- `--update-existing` - Update existing tests instead of creating new ones
- `--from-flows` - Generate E2E tests from user flow definitions
- `--pattern` - File pattern for test placement (colocated, separate, mirror)
- `--dry-run` - Show what tests would be generated without creating them
- `--watch` - Watch mode for continuous test generation

## Examples

### Basic Usage
```bash
# Generate comprehensive test suite
@test-gen

# Generate missing unit tests only
@test-gen src/services/ --only-untested

# Generate tests with 90% coverage target
@test-gen src/ --coverage-target 90 --type unit
```

### Advanced Usage
```bash
# Generate E2E tests from user flows
@test-gen --type e2e --from-flows src/features/

# Generate integration tests with custom mocks
@test-gen src/api/ --type integration --mocks manual

# Update existing tests with new patterns
@test-gen --update-existing --style given/when/then

# Generate tests for specific framework
@test-gen --framework playwright --type e2e
```

### Framework-Specific Examples
```bash
# React component tests
@test-gen src/components/ --type unit --framework jest

# Vue component tests  
@test-gen src/components/ --type unit --framework vitest

# API endpoint tests
@test-gen src/routes/ --type integration --coverage-target 95

# Full-stack E2E tests
@test-gen --type e2e --from-flows docs/user-flows.md
```

## Phase 1: Analysis Agents (Parallel)

### Agent 1: Coverage Analyzer
```
Analyze test coverage gaps in [TARGET]

Tasks:
1. Existing Coverage Analysis:
   - Parse coverage reports (lcov, clover, json)
   - Identify uncovered lines/branches
   - Find uncovered functions/methods
   - Analyze conditional coverage gaps
   - Map coverage to business logic

2. Code Path Analysis:
   - Identify all execution paths
   - Map conditional branches
   - Find error handling paths
   - Analyze async code paths
   - Detect edge cases

3. Test Quality Assessment:
   - Evaluate existing test effectiveness
   - Find shallow/ineffective tests
   - Identify missing assertions
   - Check test maintainability
   - Assess test isolation

4. Priority Mapping:
   - Critical path identification
   - Business value assessment
   - Risk-based prioritization
   - Complexity vs coverage gaps
   - User-facing functionality focus

Return:
- Coverage gap report with file:line details
- Execution path map
- Test quality scores
- Priority matrix for test generation
- Existing test analysis
```

### Agent 2: Code Behavior Mapper
```
Map code behavior patterns in [TARGET]

Tasks:
1. Function Behavior Analysis:
   - Input/output relationships
   - Side effect identification
   - State mutation patterns
   - Error conditions
   - Performance characteristics

2. Component Behavior Mapping:
   - Props and state relationships
   - Event handling patterns
   - Lifecycle behavior
   - Rendering conditions
   - User interaction flows

3. API Behavior Analysis:
   - Request/response patterns
   - Error scenarios
   - Authentication flows
   - Data validation rules
   - Rate limiting behavior

4. Integration Point Mapping:
   - Database interactions
   - External API calls
   - File system operations
   - Network dependencies
   - Third-party service integration

Return:
- Behavior specification for each function/component
- Input/output matrices
- Error scenario catalog
- Integration dependency map
- State transition diagrams
```

### Agent 3: Pattern Recognition Agent
```
Analyze existing test patterns in [TARGET]

Tasks:
1. Test Structure Analysis:
   - Common test patterns in codebase
   - Naming conventions
   - File organization
   - Setup/teardown patterns
   - Assertion styles

2. Mock Strategy Analysis:
   - Current mocking approaches
   - Mock object patterns
   - Spy usage patterns
   - Test data generation
   - Fixture management

3. Framework Usage Patterns:
   - Testing library usage
   - Custom test utilities
   - Test helper functions
   - Configuration patterns
   - Plugin usage

4. Quality Patterns:
   - Test readability standards
   - Error message patterns
   - Test documentation style
   - Performance test patterns
   - Security test approaches

Return:
- Test pattern catalog
- Style guide recommendations
- Framework usage analysis
- Quality benchmarks
- Best practice adherence score
```

### Agent 4: User Flow Analyzer
```
Analyze user flows for E2E test generation in [TARGET]

Tasks:
1. Flow Definition Analysis:
   - Parse user story files
   - Extract acceptance criteria
   - Map user journey steps
   - Identify critical paths
   - Find happy/sad path scenarios

2. UI Interaction Mapping:
   - Button click sequences
   - Form submission flows
   - Navigation patterns
   - Modal/dialog interactions
   - Responsive behavior

3. Business Process Analysis:
   - Multi-step workflows
   - Data persistence flows
   - Authentication journeys
   - Payment processes
   - Notification flows

4. Cross-System Integration:
   - API interaction sequences
   - External service dependencies
   - Database transaction flows
   - File upload/download processes
   - Email/SMS verification flows

Return:
- User flow specifications
- E2E test scenarios
- UI interaction sequences
- Business process maps
- Integration test requirements
```

## Phase 2: Test Generation Strategy Agent

```
Synthesize analysis results and create test generation strategy: [ALL_ANALYSIS_RESULTS]

Tasks:
1. Test Strategy Planning:
   - Prioritize test types by impact
   - Plan test suite architecture
   - Define coverage targets per module
   - Create test dependency graph
   - Estimate generation effort

2. Test Suite Design:
   - Unit test structure planning
   - Integration test boundaries
   - E2E test scenario selection
   - Performance test requirements
   - Security test considerations

3. Framework Selection:
   - Recommend optimal testing stack
   - Plan tool integration
   - Configure test environments
   - Set up CI/CD integration
   - Define reporting strategy

4. Quality Assurance:
   - Test maintainability standards
   - Code review requirements
   - Documentation standards
   - Performance benchmarks
   - Security testing protocols

Generate:
- Comprehensive test strategy document
- Test generation roadmap
- Framework recommendations
- Quality standards definition
- Implementation timeline
```

## Phase 3: Specialized Test Generation Agents (Parallel)

### Agent G1: Unit Test Generator
```
Generate unit tests based on strategy: [UNIT_TEST_STRATEGY]

Tasks:
1. Function Test Generation:
   - Generate tests for each function
   - Cover all input combinations
   - Test edge cases and boundaries
   - Validate return values
   - Test error conditions

2. Component Test Generation:
   - Render tests for all props
   - Event handler testing
   - State change validation
   - Lifecycle method testing
   - Conditional rendering tests

3. Class Test Generation:
   - Method testing with mocks
   - Property validation
   - Constructor testing
   - Inheritance testing
   - Static method testing

4. Mock Generation:
   - Auto-generate mocks for dependencies
   - Create test data factories
   - Generate spy configurations
   - Create stub implementations
   - Build fixture data

Requirements:
- Follow established patterns
- Achieve coverage targets
- Include descriptive test names
- Add helpful comments
- Use consistent assertions
```

### Agent G2: Integration Test Generator
```
Generate integration tests: [INTEGRATION_TEST_STRATEGY]

Tasks:
1. API Integration Tests:
   - Endpoint testing with real requests
   - Authentication flow testing
   - Data validation testing
   - Error response testing
   - Rate limiting testing

2. Database Integration Tests:
   - CRUD operation testing
   - Transaction testing
   - Constraint validation
   - Performance testing
   - Migration testing

3. Service Integration Tests:
   - Inter-service communication
   - Event-driven testing
   - Message queue testing
   - Cache integration testing
   - File system testing

4. Third-Party Integration Tests:
   - External API testing
   - Payment gateway testing
   - Email service testing
   - Cloud service testing
   - Webhook testing

Requirements:
- Use test databases
- Mock external services appropriately
- Test real integration points
- Include setup/teardown
- Handle async operations
```

### Agent G3: E2E Test Generator
```
Generate end-to-end tests: [E2E_TEST_STRATEGY]

Tasks:
1. User Journey Tests:
   - Convert user flows to tests
   - Multi-page workflows
   - Cross-browser testing
   - Mobile responsive testing
   - Accessibility testing

2. Business Process Tests:
   - Complete workflow testing
   - Data persistence validation
   - Multi-user scenarios
   - Real-time feature testing
   - Background process testing

3. Performance Tests:
   - Load testing scenarios
   - Stress testing
   - Performance regression tests
   - Memory leak detection
   - Resource usage monitoring

4. Security Tests:
   - Authentication testing
   - Authorization testing
   - Input validation testing
   - XSS/CSRF testing
   - Data privacy testing

Requirements:
- Use page object patterns
- Include wait strategies
- Handle dynamic content
- Test multiple environments
- Include screenshot/video capture
```

### Agent G4: Test Utility Generator
```
Generate test utilities and fixtures: [UTILITY_REQUIREMENTS]

Tasks:
1. Test Data Factories:
   - Generate realistic test data
   - Create data builders
   - Build object mothers
   - Generate mock responses
   - Create test databases

2. Helper Functions:
   - Custom assertion helpers
   - Setup/teardown utilities
   - Mock generation helpers
   - Test environment utilities
   - Common test patterns

3. Configuration Generation:
   - Test runner configuration
   - Coverage configuration
   - Mock configuration
   - Environment setup
   - CI/CD configuration

4. Documentation Generation:
   - Test documentation
   - Setup instructions
   - Best practice guides
   - Troubleshooting guides
   - Maintenance procedures

Requirements:
- Reusable across test types
- Well-documented
- Follow project conventions
- Include examples
- Easy to maintain
```

## Phase 4: Test Orchestration Agent

```
Coordinate test generation and validation: [ALL_GENERATED_TESTS]

Tasks:
1. Test Organization:
   - Organize tests by type and module
   - Create test suites
   - Set up test hierarchies
   - Configure test runners
   - Establish naming conventions

2. Quality Validation:
   - Run generated tests
   - Verify coverage targets
   - Check test performance
   - Validate test reliability
   - Review test maintainability

3. Integration Setup:
   - Configure CI/CD pipelines
   - Set up test environments
   - Configure test databases
   - Set up test data management
   - Configure reporting

4. Documentation Creation:
   - Generate test documentation
   - Create maintenance guides
   - Document test patterns
   - Create troubleshooting guides
   - Generate coverage reports

Generate:
- Complete test suite
- Test configuration files
- Documentation package
- CI/CD integration
- Quality metrics report
```

## Output Examples

### Unit Test Generation
```typescript
// Generated: src/services/userService.test.ts
import { UserService } from './userService';
import { userRepository } from '../repositories/userRepository';
import { emailService } from './emailService';

jest.mock('../repositories/userRepository');
jest.mock('./emailService');

describe('UserService', () => {
  let userService: UserService;
  const mockUserRepository = userRepository as jest.Mocked<typeof userRepository>;
  const mockEmailService = emailService as jest.Mocked<typeof emailService>;

  beforeEach(() => {
    userService = new UserService(mockUserRepository, mockEmailService);
    jest.clearAllMocks();
  });

  describe('createUser', () => {
    it('should create user with valid data', async () => {
      // Arrange
      const userData = { name: 'John Doe', email: 'john@example.com' };
      const expectedUser = { id: 1, ...userData };
      mockUserRepository.create.mockResolvedValue(expectedUser);

      // Act
      const result = await userService.createUser(userData);

      // Assert
      expect(mockUserRepository.create).toHaveBeenCalledWith(userData);
      expect(mockEmailService.sendWelcomeEmail).toHaveBeenCalledWith(expectedUser);
      expect(result).toEqual(expectedUser);
    });

    it('should throw error for invalid email', async () => {
      // Arrange
      const userData = { name: 'John Doe', email: 'invalid-email' };

      // Act & Assert
      await expect(userService.createUser(userData)).rejects.toThrow('Invalid email format');
      expect(mockUserRepository.create).not.toHaveBeenCalled();
    });
  });
});
```

### Integration Test Generation
```typescript
// Generated: src/api/users.integration.test.ts
import request from 'supertest';
import { app } from '../app';
import { testDb } from '../test/testDb';
import { createTestUser } from '../test/factories/userFactory';

describe('Users API Integration', () => {
  beforeAll(async () => {
    await testDb.connect();
  });

  afterAll(async () => {
    await testDb.disconnect();
  });

  beforeEach(async () => {
    await testDb.clearTables();
  });

  describe('POST /api/users', () => {
    it('should create user and return 201', async () => {
      // Arrange
      const userData = {
        name: 'John Doe',
        email: 'john@example.com',
        password: 'securePassword123'
      };

      // Act
      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(201);

      // Assert
      expect(response.body).toMatchObject({
        id: expect.any(Number),
        name: userData.name,
        email: userData.email
      });
      expect(response.body.password).toBeUndefined();
    });

    it('should return 400 for duplicate email', async () => {
      // Arrange
      const existingUser = await createTestUser();
      const userData = {
        name: 'Jane Doe',
        email: existingUser.email,
        password: 'password123'
      };

      // Act & Assert
      await request(app)
        .post('/api/users')
        .send(userData)
        .expect(400)
        .expect((res) => {
          expect(res.body.error).toMatch(/email already exists/i);
        });
    });
  });
});
```

### E2E Test Generation
```typescript
// Generated: tests/e2e/userRegistration.e2e.test.ts
import { test, expect } from '@playwright/test';
import { UserRegistrationPage } from '../pages/UserRegistrationPage';
import { DashboardPage } from '../pages/DashboardPage';

test.describe('User Registration Flow', () => {
  test('should complete full registration and login flow', async ({ page }) => {
    // Arrange
    const userRegistrationPage = new UserRegistrationPage(page);
    const dashboardPage = new DashboardPage(page);
    const testUser = {
      name: 'John Doe',
      email: `test-${Date.now()}@example.com`,
      password: 'SecurePassword123!'
    };

    // Act - Registration
    await userRegistrationPage.goto();
    await userRegistrationPage.fillRegistrationForm(testUser);
    await userRegistrationPage.submitForm();

    // Assert - Email verification
    await expect(page.getByText('Please check your email')).toBeVisible();
    
    // Simulate email verification (in real test, you'd check email service)
    await page.goto('/verify-email?token=mock-token');
    await expect(page.getByText('Email verified successfully')).toBeVisible();

    // Act - Login
    await userRegistrationPage.loginWithCredentials(testUser.email, testUser.password);

    // Assert - Dashboard access
    await expect(dashboardPage.welcomeMessage).toContainText(`Welcome, ${testUser.name}`);
    await expect(dashboardPage.userProfile).toBeVisible();
  });

  test('should handle registration with existing email', async ({ page }) => {
    // Arrange
    const userRegistrationPage = new UserRegistrationPage(page);
    const existingUser = {
      name: 'Existing User',
      email: 'existing@example.com',
      password: 'password123'
    };

    // Act
    await userRegistrationPage.goto();
    await userRegistrationPage.fillRegistrationForm(existingUser);
    await userRegistrationPage.submitForm();

    // Assert
    await expect(page.getByText('Email already registered')).toBeVisible();
    await expect(page.getByRole('button', { name: 'Sign In Instead' })).toBeVisible();
  });
});
```

## Configuration Files

### Test Configuration
```json
{
  "testGeneration": {
    "framework": "jest",
    "coverage": {
      "target": 80,
      "threshold": {
        "statements": 80,
        "branches": 75,
        "functions": 80,
        "lines": 80
      }
    },
    "patterns": {
      "unit": "**/*.test.{ts,js}",
      "integration": "**/*.integration.test.{ts,js}",
      "e2e": "tests/e2e/**/*.e2e.test.{ts,js}"
    },
    "mocks": {
      "strategy": "auto",
      "external": true,
      "database": true
    },
    "style": "describe/it",
    "parallel": true
  }
}
```

### Jest Configuration
```javascript
// Generated: jest.config.js
module.exports = {
  testEnvironment: 'node',
  roots: ['<rootDir>/src', '<rootDir>/tests'],
  testMatch: [
    '**/__tests__/**/*.{ts,js}',
    '**/*.{test,spec}.{ts,js}'
  ],
  collectCoverageFrom: [
    'src/**/*.{ts,js}',
    '!src/**/*.d.ts',
    '!src/test/**/*'
  ],
  coverageThreshold: {
    global: {
      branches: 75,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  setupFilesAfterEnv: ['<rootDir>/tests/setup.ts'],
  testTimeout: 10000
};
```

### Playwright Configuration
```typescript
// Generated: playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure'
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    }
  ],
  webServer: {
    command: 'npm run start',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  }
});
```

## Test Generation Report

### Example Output
```
🧪 Test Generation Complete
===========================

📊 Summary
- Total Tests Generated: 247
- Unit Tests: 156
- Integration Tests: 67
- E2E Tests: 24
- Test Coverage: 87.3% (target: 80%)
- Generation Time: 4.2 minutes

🎯 Coverage Achieved
- Statements: 87.3% (target: 80%) ✅
- Branches: 83.1% (target: 75%) ✅
- Functions: 91.2% (target: 80%) ✅
- Lines: 86.9% (target: 80%) ✅

📁 Files Generated
- Unit Tests: 45 files
- Integration Tests: 12 files
- E2E Tests: 8 files
- Test Utilities: 15 files
- Configuration: 6 files

⚡ Performance Metrics
- Average Test Runtime: 120ms
- Slowest Test: 2.3s (E2E checkout flow)
- Parallel Execution: 8 workers
- Total Suite Runtime: 3.4 minutes

🔧 Test Quality
- Mock Usage: 89% appropriate
- Assertion Quality: 92% meaningful
- Test Isolation: 100% isolated
- Maintainability Score: 8.7/10

📋 Next Steps
1. Review generated tests for business logic accuracy
2. Add custom test data for domain-specific scenarios
3. Configure CI/CD pipeline integration
4. Set up test monitoring and alerting
5. Schedule regular test maintenance reviews
```

## Framework Support

### Jest/Vitest
- Automatic mock generation
- Snapshot testing
- Coverage reporting
- Custom matchers
- Test environment setup

### Cypress/Playwright
- Page object models
- Visual testing
- API testing
- Mobile testing
- Cross-browser testing

### React Testing Library
- Component testing
- User event simulation
- Accessibility testing
- Custom render functions
- Hook testing

### Vue Test Utils
- Component mounting
- Event testing
- Slot testing
- Directive testing
- Composition API testing

## Best Practices

1. **Test Pyramid**: Focus on unit tests, selective integration tests, critical E2E tests
2. **Test Independence**: Each test should be able to run in isolation
3. **Descriptive Names**: Test names should clearly describe what is being tested
4. **AAA Pattern**: Arrange, Act, Assert for clear test structure
5. **Mock Appropriately**: Mock external dependencies, not internal logic
6. **Test Data**: Use factories and builders for consistent test data
7. **Coverage Goals**: Aim for meaningful coverage, not just high percentages
8. **Maintenance**: Regularly review and update generated tests

## Integration Examples

### CI/CD Pipeline
```yaml
# .github/workflows/test.yml
name: Test Suite
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install dependencies
        run: npm ci
      - name: Run unit tests
        run: npm run test:unit
      - name: Run integration tests
        run: npm run test:integration
      - name: Run E2E tests
        run: npm run test:e2e
      - name: Upload coverage
        uses: codecov/codecov-action@v3
```

### VS Code Integration
```json
{
  "command": "claude.generateTests",
  "title": "Generate Tests",
  "key": "cmd+shift+t"
}
```

### Package.json Scripts
```json
{
  "scripts": {
    "test": "jest",
    "test:unit": "jest --testPathPattern='.test.'",
    "test:integration": "jest --testPathPattern='.integration.test.'",
    "test:e2e": "playwright test",
    "test:coverage": "jest --coverage",
    "test:watch": "jest --watch",
    "test:generate": "@test-gen"
  }
}
```