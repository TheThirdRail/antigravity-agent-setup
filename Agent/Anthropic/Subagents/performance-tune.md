---
name: performance-tune
description: |
  Systematic performance optimization workflow with benchmarking
---

<subagent name="performance-tune" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Systematic performance optimization workflow with benchmarking</purpose>

  <when_to_use>
    <trigger>Application is slow and needs optimization</trigger>
    <trigger>Preparing for expected traffic increase</trigger>
    <trigger>Performance budget exceeded</trigger>
    <trigger>User complaints about speed</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Define Performance Goals">
      <action>Establish concrete, measurable targets</action>
      <action>What specific metric needs to improve?</action>
    </step>
    <step number="2" name="Establish Baseline">
      <action>Measure current performance before any changes</action>
      <action>| Metric | Current | Target | |--------|---------|--------| | p95 latency | X ms | Y ms | | Throughput | X req/s | Y req/s |</action>
    </step>
    <step number="3" name="Profile and Identify Bottlenecks">
      <action>Use profiling tools to find where time is spent</action>
      <action>Ranked list of top 3 bottlenecks</action>
    </step>
    <step number="4" name="Optimize Bottleneck #1">
      <action>Address the highest-impact issue</action>
    </step>
    <step number="5" name="Benchmark After Change">
      <action>Re-run performance tests and measure improvement</action>
      <action>| Metric | Before | After | Improvement | |--------|--------|-------|-------------| | Target metric | X | Y | Z% |</action>
    </step>
    <step number="6" name="Repeat for Remaining Bottlenecks">
      <action>Apply same process for bottlenecks #2 and #3</action>
      <action>Stop when performance goal is reached</action>
    </step>
    <step number="7" name="Final Benchmark">
      <action>Run comprehensive performance test suite</action>
      <action>Performance Optimization Report: before metrics, after metrics, improvement percentage, optimizations applied with impact, and trade-offs made.</action>
    </step>
    <step number="8" name="Document and Monitor">
      <action>Record optimizations for future reference</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>Performance goals met or exceeded</criterion>
    <criterion>No functionality regressions</criterion>
    <criterion>Optimizations documented</criterion>
    <criterion>Monitoring in place</criterion>
  </output_contract>

  <handoffs>
    <route>/analyze</route>
    <route>/deploy</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

