# Sub-Agent Performance Optimizer Command

A comprehensive full-stack performance optimization command that orchestrates specialized sub-agents to analyze, benchmark, and optimize performance across all layers of your application stack.

## Command Syntax

```bash
sub-agent-performance-optimizer [target] [options]

# Aliases
@perf-optimize [target] [options]
@performance [target] [options]
@sapo [target] [options]
```

## Parameters

### Target
- `target` - Directory, file, or component to optimize (defaults to current directory)

### Options
- `--target` - Optimization target (frontend, backend, database, full-stack, all)
- `--baseline` - Baseline performance file for comparison
- `--bundle-analysis` - Analyze bundle size and composition
- `--suggest-indexes` - Suggest database indexes
- `--memory-profile` - Profile memory usage
- `--runtime-profile` - Profile runtime performance
- `--threshold` - Performance threshold (strict, standard, relaxed)
- `--fix-level` - Auto-fix level (safe, recommended, aggressive)
- `--cache-strategy` - Analyze and optimize caching
- `--cdn-optimization` - Optimize for CDN delivery
- `--mobile-first` - Prioritize mobile performance
- `--output` - Output format (json, html, markdown)
- `--compare-with` - Compare with previous performance report
- `--budget` - Performance budget configuration

## Examples

### Basic Usage
```bash
# Full-stack performance optimization
@perf-optimize

# Frontend-only optimization with bundle analysis
@perf-optimize src/ --target frontend --bundle-analysis

# Database optimization with index suggestions
@perf-optimize --target database --suggest-indexes

# Compare with baseline
@performance . --baseline perf-baseline.json
```

### Advanced Usage
```bash
# Comprehensive analysis with memory profiling
@perf-optimize --target full-stack \
  --memory-profile \
  --runtime-profile \
  --cache-strategy \
  --threshold strict

# Mobile-first optimization
@perf-optimize src/ \
  --target frontend \
  --mobile-first \
  --cdn-optimization \
  --budget mobile-budget.json

# Production-ready optimization
@perf-optimize \
  --fix-level aggressive \
  --bundle-analysis \
  --suggest-indexes \
  --compare-with last-report.json
```

## Multi-Agent Orchestration

### Stage 1: Performance Assessment (Parallel Analysis)

#### Agent 1: Frontend Performance Analyzer
```
Analyze frontend performance in [TARGET]

Tasks:
1. Bundle Analysis:
   - Bundle size breakdown
   - Code splitting opportunities
   - Unused code detection
   - Tree-shaking effectiveness
   - Dynamic import usage

2. Runtime Performance:
   - Component render times
   - Re-render frequency
   - Memory leaks detection
   - Event listener efficiency
   - DOM manipulation costs

3. Loading Performance:
   - First Contentful Paint (FCP)
   - Largest Contentful Paint (LCP)
   - Time to Interactive (TTI)
   - Cumulative Layout Shift (CLS)
   - Resource loading waterfall

4. Framework-Specific Issues:
   - React: Unnecessary re-renders, prop drilling
   - Vue: Reactivity inefficiencies
   - Angular: Change detection cycles
   - Svelte: Bundle optimization

5. Asset Optimization:
   - Image compression opportunities
   - Font loading strategies
   - CSS optimization
   - JavaScript minification
   - Resource preloading

Return:
- Performance metrics
- Optimization opportunities
- Bundle analysis report
- Critical path analysis
- Mobile performance score
```

#### Agent 2: Backend Performance Analyzer
```
Analyze backend performance in [TARGET]

Tasks:
1. API Performance:
   - Response time analysis
   - Throughput measurements
   - Error rate tracking
   - Concurrent request handling
   - Rate limiting effectiveness

2. Database Interactions:
   - Query performance
   - N+1 query detection
   - Connection pooling
   - Transaction efficiency
   - ORM optimization

3. Memory & CPU Analysis:
   - Memory usage patterns
   - Garbage collection impact
   - CPU bottlenecks
   - Resource leak detection
   - Async operation efficiency

4. Caching Analysis:
   - Cache hit rates
   - Cache invalidation
   - Redis/Memcached usage
   - CDN effectiveness
   - Browser caching

5. Architecture Performance:
   - Service communication
   - Load balancing
   - Microservice efficiency
   - Message queue performance
   - Session management

Return:
- API performance metrics
- Database query analysis
- Memory/CPU profiles
- Caching recommendations
- Scalability assessment
```

#### Agent 3: Database Performance Analyzer
```
Analyze database performance in [TARGET]

Tasks:
1. Query Performance:
   - Slow query identification
   - Query execution plans
   - Index usage analysis
   - Join optimization
   - Subquery efficiency

2. Index Analysis:
   - Missing index detection
   - Unused index identification
   - Composite index opportunities
   - Index fragmentation
   - Partial index potential

3. Schema Optimization:
   - Table structure efficiency
   - Data type optimization
   - Normalization/denormalization
   - Partitioning opportunities
   - Archiving strategies

4. Connection & Resources:
   - Connection pool analysis
   - Lock contention
   - Deadlock detection
   - Transaction scope
   - Resource utilization

5. Database-Specific:
   - PostgreSQL: VACUUM efficiency
   - MySQL: InnoDB optimization
   - MongoDB: Aggregation pipeline
   - Redis: Memory usage patterns
   - SQLite: WAL mode benefits

Return:
- Slow query report
- Index recommendations
- Schema optimization suggestions
- Connection pool analysis
- Performance bottlenecks
```

#### Agent 4: Infrastructure Performance Analyzer
```
Analyze infrastructure performance in [TARGET]

Tasks:
1. Server Performance:
   - CPU utilization patterns
   - Memory usage trends
   - Disk I/O performance
   - Network latency
   - Load distribution

2. CDN & Caching:
   - CDN hit rates
   - Geographic performance
   - Cache invalidation
   - Edge server efficiency
   - Static asset delivery

3. Load Balancing:
   - Traffic distribution
   - Health check efficiency
   - Failover performance
   - Session persistence
   - SSL termination

4. Monitoring & Metrics:
   - Application metrics
   - Error tracking
   - Performance monitoring
   - Alerting effectiveness
   - Log analysis

5. Scalability Patterns:
   - Horizontal scaling
   - Vertical scaling
   - Auto-scaling triggers
   - Resource provisioning
   - Cost optimization

Return:
- Infrastructure metrics
- CDN performance analysis
- Load balancing assessment
- Scalability recommendations
- Cost-performance optimization
```

### Stage 2: Performance Synthesis Agent

```
Synthesize performance analysis from all agents: [ALL_PERFORMANCE_DATA]

Tasks:
1. Performance Overview:
   - Overall performance score
   - Critical bottlenecks
   - Performance trends
   - User experience impact
   - Business impact assessment

2. Bottleneck Identification:
   - Primary performance blockers
   - Cascading effects
   - Resource constraints
   - Architectural limitations
   - Third-party dependencies

3. Optimization Prioritization:
   - High-impact, low-effort fixes
   - Quick wins identification
   - Long-term improvements
   - Resource requirements
   - Risk assessment

4. Performance Budget:
   - Current vs target metrics
   - Budget violations
   - Acceptable thresholds
   - Monitoring recommendations
   - Regression prevention

5. Holistic Recommendations:
   - Cross-layer optimizations
   - Architecture improvements
   - Technology upgrades
   - Process changes
   - Team training needs

Generate:
- Executive performance summary
- Detailed optimization roadmap
- Performance budget analysis
- Implementation timeline
- Success metrics
```

### Stage 3: Performance Optimization Agents (Parallel)

#### Agent O1: Frontend Optimizer
```
Optimize frontend performance based on analysis: [FRONTEND_ISSUES]

Optimizations:
1. Bundle Optimization:
   - Code splitting implementation
   - Tree-shaking improvements
   - Dynamic imports
   - Bundle analysis setup
   - Webpack/Vite configuration

2. Component Optimization:
   - React.memo implementation
   - useMemo/useCallback optimization
   - Virtual scrolling
   - Image lazy loading
   - Component splitting

3. Asset Optimization:
   - Image compression
   - WebP conversion
   - Font optimization
   - CSS minification
   - Resource preloading

4. Performance Monitoring:
   - Web Vitals tracking
   - Performance budgets
   - Monitoring setup
   - Alert configuration
   - Performance CI/CD

Requirements:
- Maintain functionality
- Preserve user experience
- Follow framework best practices
- Implement monitoring
```

#### Agent O2: Backend Optimizer
```
Optimize backend performance based on analysis: [BACKEND_ISSUES]

Optimizations:
1. API Optimization:
   - Response caching
   - Request batching
   - Connection pooling
   - Async processing
   - Rate limiting

2. Database Optimization:
   - Query optimization
   - Index creation
   - Connection pooling
   - Caching layer
   - ORM configuration

3. Memory & CPU:
   - Memory leak fixes
   - Garbage collection tuning
   - CPU optimization
   - Resource pooling
   - Async operation improvements

4. Caching Strategy:
   - Redis implementation
   - Cache invalidation
   - CDN configuration
   - Browser caching
   - Application caching

Requirements:
- Maintain data integrity
- Preserve business logic
- Ensure scalability
- Monitor performance
```

#### Agent O3: Database Optimizer
```
Optimize database performance based on analysis: [DATABASE_ISSUES]

Optimizations:
1. Index Management:
   - Create missing indexes
   - Remove unused indexes
   - Composite index optimization
   - Partial index creation
   - Index maintenance

2. Query Optimization:
   - Slow query rewriting
   - Join optimization
   - Subquery improvements
   - Execution plan analysis
   - Parameter binding

3. Schema Optimization:
   - Data type optimization
   - Table partitioning
   - Archiving strategies
   - Normalization fixes
   - Constraint optimization

4. Configuration Tuning:
   - Connection pooling
   - Memory allocation
   - Cache configuration
   - Logging optimization
   - Backup optimization

Requirements:
- Maintain data integrity
- Preserve relationships
- Ensure ACID compliance
- Monitor performance
```

#### Agent O4: Infrastructure Optimizer
```
Optimize infrastructure based on analysis: [INFRASTRUCTURE_ISSUES]

Optimizations:
1. Server Configuration:
   - Resource allocation
   - Process optimization
   - Network configuration
   - Security hardening
   - Monitoring setup

2. CDN & Caching:
   - CDN configuration
   - Cache strategies
   - Geographic optimization
   - Edge server setup
   - Cache invalidation

3. Load Balancing:
   - Traffic distribution
   - Health checks
   - Failover configuration
   - Session management
   - SSL optimization

4. Monitoring & Alerts:
   - Performance monitoring
   - Error tracking
   - Alert configuration
   - Log analysis
   - Reporting setup

Requirements:
- Maintain availability
- Preserve security
- Ensure scalability
- Monitor continuously
```

### Stage 4: Performance Validation Agent

```
Validate performance improvements: [OPTIMIZATION_RESULTS]

Tasks:
1. Performance Testing:
   - Load testing
   - Stress testing
   - Endurance testing
   - Spike testing
   - Volume testing

2. Metrics Comparison:
   - Before/after metrics
   - Performance gains
   - Regression detection
   - Budget compliance
   - User experience impact

3. Monitoring Setup:
   - Performance dashboards
   - Alert configuration
   - Continuous monitoring
   - Regression detection
   - Reporting automation

4. Documentation:
   - Optimization summary
   - Performance gains
   - Monitoring guide
   - Maintenance recommendations
   - Best practices

Generate:
- Performance improvement report
- Monitoring dashboard
- Regression prevention guide
- Performance maintenance plan
```

## Output Examples

### Performance Analysis Report
```markdown
# Performance Analysis Report

## Executive Summary
- **Overall Score**: 72/100 (Good)
- **Primary Bottleneck**: Database queries (45% of response time)
- **Potential Improvement**: 40% faster load times
- **Implementation Time**: 2-3 weeks

## Key Findings

### Frontend Performance
- **Bundle Size**: 2.3MB (Target: <1MB)
- **LCP**: 3.2s (Target: <2.5s)
- **TTI**: 4.1s (Target: <3.5s)
- **CLS**: 0.15 (Target: <0.1)

### Backend Performance
- **API Response Time**: 850ms avg (Target: <500ms)
- **Database Query Time**: 380ms avg (Target: <200ms)
- **Memory Usage**: 2.1GB (85% of available)
- **Cache Hit Rate**: 45% (Target: >80%)

### Database Performance
- **Slow Queries**: 23 queries >1s
- **Missing Indexes**: 8 recommended
- **N+1 Queries**: 15 detected
- **Connection Pool**: 70% utilization

## Optimization Roadmap

### Phase 1: Quick Wins (1 week)
1. **Bundle Optimization**
   - Implement code splitting → -40% bundle size
   - Add tree-shaking → -15% bundle size
   - Optimize images → -25% asset size

2. **Database Indexes**
   - Add composite index on user_orders → -60% query time
   - Index created_at columns → -30% query time
   - Remove unused indexes → +5% write performance

### Phase 2: Major Improvements (2 weeks)
1. **Caching Layer**
   - Redis caching → +70% cache hit rate
   - API response caching → -50% response time
   - CDN optimization → -30% asset load time

2. **Query Optimization**
   - Fix N+1 queries → -40% database load
   - Optimize joins → -25% query time
   - Connection pooling → +20% throughput

### Phase 3: Advanced Optimizations (1 week)
1. **Component Optimization**
   - React.memo implementation → -30% re-renders
   - Virtual scrolling → -80% initial render time
   - Lazy loading → -50% initial bundle size

2. **Infrastructure**
   - CDN setup → -60% global load time
   - Load balancing → +100% capacity
   - Auto-scaling → Dynamic resource allocation

## Performance Budget
```json
{
  "budgets": {
    "frontend": {
      "initialBundle": "800KB",
      "lcp": "2.5s",
      "tti": "3.5s",
      "cls": "0.1"
    },
    "backend": {
      "apiResponse": "500ms",
      "databaseQuery": "200ms",
      "memoryUsage": "70%",
      "cacheHitRate": "80%"
    }
  }
}
```

## Implementation Plan
1. **Week 1**: Bundle optimization + Database indexes
2. **Week 2**: Caching layer + Query optimization
3. **Week 3**: Component optimization + Infrastructure
4. **Week 4**: Testing + Monitoring setup

## Success Metrics
- Page load time: 3.2s → 1.9s (40% improvement)
- API response time: 850ms → 420ms (50% improvement)
- Bundle size: 2.3MB → 1.1MB (52% reduction)
- Cache hit rate: 45% → 82% (82% improvement)
```

### Bundle Analysis Report
```
📦 Bundle Analysis Report
========================

🎯 Bundle Overview
- Total Size: 2.3MB (gzipped: 850KB)
- Chunks: 12 (5 async, 7 sync)
- Modules: 1,247
- Duplicate Code: 340KB (15% of bundle)

📊 Size Breakdown
1. node_modules/: 1.8MB (78%)
   - react/react-dom: 320KB
   - lodash: 180KB (⚠️ Consider lodash-es)
   - moment: 160KB (⚠️ Consider date-fns)
   - unused packages: 240KB

2. src/: 450KB (20%)
   - components/: 180KB
   - utils/: 120KB
   - pages/: 150KB

3. assets/: 50KB (2%)
   - images: 30KB
   - fonts: 20KB

🚀 Optimization Opportunities
1. **Tree Shaking** (-180KB)
   - Remove unused lodash functions
   - Eliminate dead code in utils/
   - Optimize moment.js imports

2. **Code Splitting** (-400KB initial)
   - Lazy load routes
   - Split vendor chunks
   - Dynamic component imports

3. **Package Optimization** (-200KB)
   - Replace moment with date-fns
   - Use lodash-es instead of lodash
   - Remove unused dependencies

4. **Asset Optimization** (-30KB)
   - Compress images to WebP
   - Optimize font loading
   - Minify CSS

🎯 Recommended Actions
1. Implement dynamic imports for routes
2. Replace heavy libraries with lighter alternatives
3. Add webpack-bundle-analyzer to CI/CD
4. Set up performance budgets
5. Monitor bundle size in PRs

📈 Expected Results
- Bundle size: 2.3MB → 1.1MB (52% reduction)
- Initial load: 3.2s → 1.9s (40% improvement)
- Cache efficiency: +35% (smaller chunks)
```

## Configuration

### Performance Budget (performance-budget.json)
```json
{
  "budgets": {
    "frontend": {
      "initialBundle": "800KB",
      "totalAssets": "2MB",
      "lcp": "2.5s",
      "fcp": "1.8s",
      "tti": "3.5s",
      "cls": "0.1",
      "fid": "100ms"
    },
    "backend": {
      "apiResponse": "500ms",
      "databaseQuery": "200ms",
      "memoryUsage": "70%",
      "cpuUsage": "80%",
      "cacheHitRate": "80%",
      "errorRate": "1%"
    },
    "database": {
      "queryTime": "200ms",
      "connectionPool": "80%",
      "lockWaitTime": "50ms",
      "indexUsage": "90%"
    }
  },
  "thresholds": {
    "warning": 0.9,
    "error": 1.2
  }
}
```

### Optimization Config (.perfoptimize)
```yaml
optimization:
  frontend:
    bundleAnalysis: true
    codesplitting: true
    treeshaking: true
    assetOptimization: true
    
  backend:
    queryOptimization: true
    caching: true
    connectionPooling: true
    memoryProfiling: true
    
  database:
    indexOptimization: true
    queryAnalysis: true
    connectionOptimization: true
    
  infrastructure:
    cdnOptimization: true
    loadBalancing: true
    caching: true
    monitoring: true

targets:
  - frontend
  - backend
  - database

thresholds:
  performance: standard
  autofix: safe
  
monitoring:
  enabled: true
  dashboards: true
  alerts: true
  reports: weekly
```

## Framework-Specific Optimizations

### React Applications
```javascript
// Performance optimizations applied
export const OptimizedComponent = memo(({ data, onUpdate }) => {
  const memoizedData = useMemo(() => 
    processData(data), [data]
  );
  
  const handleUpdate = useCallback((id) => {
    onUpdate(id);
  }, [onUpdate]);
  
  return (
    <VirtualizedList
      data={memoizedData}
      onUpdate={handleUpdate}
      itemSize={60}
      windowSize={10}
    />
  );
});
```

### Node.js/Express Applications
```javascript
// Performance optimizations applied
const express = require('express');
const compression = require('compression');
const helmet = require('helmet');

const app = express();

// Compression middleware
app.use(compression());

// Security middleware
app.use(helmet());

// Response caching
app.use('/api', cacheMiddleware({
  ttl: 300, // 5 minutes
  key: (req) => `${req.method}:${req.originalUrl}`
}));

// Connection pooling
const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  // ... other config
});
```

### Database Optimizations
```sql
-- Index optimizations applied
CREATE INDEX CONCURRENTLY idx_user_orders_created 
ON user_orders(user_id, created_at DESC);

CREATE INDEX CONCURRENTLY idx_products_category_price 
ON products(category_id, price) 
WHERE active = true;

-- Query optimization
EXPLAIN (ANALYZE, BUFFERS) 
SELECT u.name, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE u.created_at > NOW() - INTERVAL '30 days'
GROUP BY u.id, u.name
ORDER BY order_count DESC;
```

## Integration Examples

### CI/CD Pipeline
```yaml
performance-check:
  stage: test
  script:
    - @perf-optimize --baseline performance-baseline.json
    - npm run build
    - npm run test:performance
  artifacts:
    reports:
      performance: performance-report.json
    paths:
      - performance-report.html
  only:
    - merge_requests
```

### GitHub Actions
```yaml
name: Performance Check
on: [pull_request]

jobs:
  performance:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install dependencies
        run: npm ci
      - name: Run performance analysis
        run: @perf-optimize --target frontend --bundle-analysis
      - name: Upload performance report
        uses: actions/upload-artifact@v3
        with:
          name: performance-report
          path: performance-report.html
```

### Monitoring Integration
```javascript
// Performance monitoring setup
const { PerformanceObserver } = require('perf_hooks');

const observer = new PerformanceObserver((list) => {
  const entries = list.getEntries();
  entries.forEach((entry) => {
    if (entry.duration > 1000) { // Alert for slow operations
      console.warn(`Slow operation: ${entry.name} took ${entry.duration}ms`);
    }
  });
});

observer.observe({ entryTypes: ['measure'] });
```

## Best Practices

1. **Continuous Monitoring**
   - Set up performance dashboards
   - Monitor key metrics continuously
   - Set up alerts for performance regressions
   - Regular performance reviews

2. **Performance Budget**
   - Define clear performance budgets
   - Integrate budget checks in CI/CD
   - Monitor budget compliance
   - Regular budget reviews

3. **Optimization Strategy**
   - Start with quick wins
   - Focus on user-facing improvements
   - Measure before and after
   - Document optimization decisions

4. **Team Practices**
   - Performance-aware development
   - Code review for performance
   - Regular performance training
   - Performance testing in development

5. **Tool Integration**
   - Bundle analyzers in CI/CD
   - Performance monitoring tools
   - Load testing automation
   - Performance regression detection

6. **Documentation**
   - Performance optimization guides
   - Best practices documentation
   - Performance troubleshooting guides
   - Monitoring runbooks