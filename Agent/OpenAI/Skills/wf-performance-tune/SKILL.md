---
name: wf-performance-tune
description: |
  OpenAI Codex orchestration skill converted from `performance-tune.md`.
  Use when Application is slow and needs optimization; Preparing for expected traffic increase; Performance budget exceeded.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-performance-tune" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, performance-tune, openai, codex</keywords>
    <source_workflow>performance-tune.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-performance-tune</id>
    <name>wf-performance-tune</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Systematic performance optimization workflow with benchmarking</purpose>
    <inputs>
      <input>User request and relevant project context.</input>
    </inputs>
    <outputs>
      <output>Completed guidance, actions, or artifacts produced by this skill.</output>
    </outputs>
    <triggers>
      <trigger>Use when the frontmatter description conditions are met.</trigger>
    </triggers>
    <procedure>Follow the ordered steps in the workflow section.</procedure>
    <edge_cases>
      <edge_case>If required context is missing, gather or request it before continuing.</edge_case>
    </edge_cases>
    <safety_constraints>
      <constraint>Avoid destructive operations without explicit user intent.</constraint>
    </safety_constraints>
    <examples>
      <example>Activate this skill when the request matches its trigger conditions.</example>
    </examples>
  </spec_contract>

  <goal>Systematic performance optimization workflow with benchmarking</goal>

  <core_principles>
    <principle name="Orchestrate First">
      <rule>Act as an orchestration skill: sequence actions, call specialized skills, and keep task focus.</rule>
    </principle>
    <principle name="Deterministic Flow">
      <rule>Follow the ordered step flow from the source workflow unless constraints require adaptation.</rule>
    </principle>
    <principle name="Validation Before Completion">
      <rule>Require verification checks before marking the workflow complete.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Define Performance Goals">
      <instruction>Establish concrete, measurable targets API response time under 200ms (p95) Page load time under 3 seconds Support 1000 concurrent users What specific metric needs to improve?</instruction>
    </step>
    <step number="2" name="Establish Baseline">
      <instruction>Measure current performance before any changes Run performance tests or load tests Capture metrics (response time, throughput, resource usage) Document baseline numbers | Metric | Current | Target | |--------|---------|--------| | p95 la...</instruction>
    </step>
    <step number="3" name="Profile and Identify Bottlenecks">
      <instruction>Use profiling tools to find where time is spent Run profiler on slow paths Analyze database query times Check for N+1 queries Review external API call latency Ranked list of top 3 bottlenecks</instruction>
    </step>
    <step number="4" name="Optimize Bottleneck #1">
      <instruction>Address the highest-impact issue Add database indexes Implement caching Optimize algorithm Parallelize I/O operations Reduce payload size</instruction>
    </step>
    <step number="5" name="Benchmark After Change">
      <instruction>Re-run performance tests and measure improvement Ensure no functionality regressions | Metric | Before | After | Improvement | |--------|--------|-------|-------------| | Target metric | X | Y | Z% |</instruction>
    </step>
    <step number="6" name="Repeat for Remaining Bottlenecks">
      <instruction>Apply same process for bottlenecks #2 and #3 Stop when performance goal is reached</instruction>
    </step>
    <step number="7" name="Final Benchmark">
      <instruction>Run comprehensive performance test suite ## Performance Optimization Report **Before:** [baseline metrics] **After:** [final metrics] **Improvement:** [percentage gains] ### Optimizations Applied 1. [What was done] → [Impact] 2. [What wa...</instruction>
    </step>
    <step number="8" name="Document and Monitor">
      <instruction>Record optimizations for future reference Document what was optimized and why Set up performance monitoring/alerts Schedule periodic performance reviews</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
  </related_skills>
</skill>
