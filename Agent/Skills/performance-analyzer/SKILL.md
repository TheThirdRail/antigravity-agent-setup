---
name: performance-analyzer
description: |
  Systematically profile, benchmark, and optimize application performance.
  Use when diagnosing "why is this slow?" or optimizing critical paths.
---

<skill name="performance-analyzer" version="1.0.0">
  <metadata>
    <keywords>performance, profiling, optimization, benchmarking, caching, bottleneck</keywords>
  </metadata>

  <goal>Identify and resolve performance bottlenecks through systematic profiling and optimization.</goal>

  <when_to_use>
    <trigger>User reports "slow", "performance issue", "optimize"</trigger>
    <trigger>Load testing or profiling requests</trigger>
    <trigger>Query optimization needs</trigger>
    <trigger>Scalability concerns</trigger>
    <trigger>Memory or CPU usage issues</trigger>
  </when_to_use>

  <workflow>
    <step number="1" name="Establish Baseline">
      <instruction>Measure current performance metrics before any changes</instruction>
      <metrics>
        <metric>Response time (p50, p95, p99)</metric>
        <metric>Throughput (requests/second)</metric>
        <metric>Resource usage (CPU, memory, disk I/O)</metric>
        <metric>Database query times</metric>
      </metrics>
      <tools>
        <tool>Browser DevTools (Network, Performance tabs)</tool>
        <tool>Node.js: --inspect, clinic.js</tool>
        <tool>Python: cProfile, py-spy</tool>
        <tool>Database: EXPLAIN ANALYZE</tool>
      </tools>
    </step>

    <step number="2" name="Identify Bottlenecks">
      <instruction>Profile to find where time is being spent</instruction>
      <categories>
        <category name="CPU-bound">Heavy computation, tight loops</category>
        <category name="I/O-bound">Database queries, file access, network calls</category>
        <category name="Memory-bound">Large data structures, memory leaks</category>
        <category name="Network-bound">External API calls, slow responses</category>
      </categories>
      <output>Ranked list of top 3 bottlenecks by impact</output>
    </step>

    <step number="3" name="Apply 80/20 Rule">
      <instruction>Focus on high-impact optimizations first</instruction>
      <principle>20% of the code causes 80% of the slowness</principle>
      <priority_order>
        <item>Database queries (often biggest impact)</item>
        <item>External API calls</item>
        <item>Algorithm complexity</item>
        <item>Memory allocations</item>
      </priority_order>
    </step>

    <step number="4" name="Optimize Incrementally">
      <instruction>Apply one optimization at a time, measure after each</instruction>
      <important>Never optimize without measuring impact</important>
    </step>

    <step number="5" name="Document Results">
      <instruction>Record before/after metrics and optimizations applied</instruction>
    </step>
  </workflow>

  <patterns>
    <pattern name="Database Query Optimization">
      <techniques>
        <technique name="Add Indexes">
          On columns used in WHERE, JOIN, ORDER BY
        </technique>
        <technique name="Avoid N+1 Queries">
          Use eager loading (JOIN) instead of lazy loading
        </technique>
        <technique name="Use EXPLAIN ANALYZE">
          Understand query execution plan
        </technique>
        <technique name="Limit Result Sets">
          Paginate large queries, use LIMIT
        </technique>
        <technique name="Cache Query Results">
          For frequently accessed, rarely changed data
        </technique>
      </techniques>
    </pattern>

    <pattern name="Caching Strategies">
      <layers>
        <layer name="Application Cache">
          In-memory (Redis, Memcached) for hot data
        </layer>
        <layer name="HTTP Cache">
          Cache-Control headers, CDN caching
        </layer>
        <layer name="Database Cache">
          Query result caching, materialized views
        </layer>
        <layer name="Computed Value Cache">
          Memoization for expensive calculations
        </layer>
      </layers>
      <considerations>
        <item>Cache invalidation strategy</item>
        <item>TTL (time-to-live) settings</item>
        <item>Cache warming</item>
        <item>Memory limits</item>
      </considerations>
    </pattern>

    <pattern name="Code-Level Optimization">
      <techniques>
        <technique name="Algorithm Complexity">
          Replace O(n²) with O(n log n) or O(n)
        </technique>
        <technique name="Lazy Loading">
          Load data/resources only when needed
        </technique>
        <technique name="Async/Parallel Processing">
          Parallelize independent I/O operations
        </technique>
        <technique name="Connection Pooling">
          Reuse database/HTTP connections
        </technique>
        <technique name="Batch Operations">
          Combine multiple operations into one
        </technique>
      </techniques>
    </pattern>

    <pattern name="Frontend Performance">
      <techniques>
        <technique name="Code Splitting">
          Load only needed JavaScript
        </technique>
        <technique name="Image Optimization">
          Compress, lazy load, use modern formats (WebP)
        </technique>
        <technique name="Bundle Analysis">
          Identify large dependencies
        </technique>
        <technique name="Critical CSS">
          Inline above-the-fold styles
        </technique>
      </techniques>
    </pattern>
  </patterns>

  <quick_wins>
    <win>Add database indexes on foreign keys and frequently queried columns</win>
    <win>Enable gzip/brotli compression for responses</win>
    <win>Add HTTP caching headers</win>
    <win>Use connection pooling</win>
    <win>Paginate large lists</win>
    <win>Lazy load images and heavy components</win>
  </quick_wins>

  <antipatterns>
    <antipattern name="Premature Optimization">
      Measure first, then optimize. Don't guess.
    </antipattern>
    <antipattern name="Optimizing the Wrong Thing">
      Profile to find actual bottlenecks, not perceived ones.
    </antipattern>
    <antipattern name="Over-caching">
      Cache invalidation is hard. Only cache what's needed.
    </antipattern>
  </antipatterns>

  <related_skills>
    <skill>api-builder</skill>
    <skill>architecture-planner</skill>
  </related_skills>

  <related_workflows>
    <workflow>/performance-tune</workflow>
    <workflow>/analyze</workflow>
  </related_workflows>
</skill>
