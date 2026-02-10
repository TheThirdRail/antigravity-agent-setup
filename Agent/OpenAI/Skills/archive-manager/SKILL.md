---
name: archive-manager
description: |
  Route archive tasks to the correct archive skill (code, docs, git, graph, or
  memory). Use when the user wants to preserve, search, or inspect project
  context but has not selected a specific archive mechanism.
---

<skill name="archive-manager" version="2.0.0">
  <metadata>
    <keywords>archive, router, context, history, memory, indexing</keywords>
  </metadata>

  <spec_contract>
    <id>archive-manager</id>
    <name>archive-manager</name>
    <version>2.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Select and dispatch the correct archive capability based on the requested context operation.</purpose>
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

  <goal>Select and dispatch the correct archive capability based on the requested context operation.</goal>

  <core_principles>
    <principle name="Intent-Based Routing">
      <rule>Route based on the data type and retrieval intent, not tool familiarity.</rule>
      <rule>Choose one primary archive path first, then compose with others only when needed.</rule>
    </principle>

    <principle name="Storage Awareness">
      <rule>Keep archive outputs project-scoped unless explicitly requested otherwise.</rule>
      <rule>Prefer deterministic paths under Agent-Context/Archives.</rule>
    </principle>

    <principle name="Traceable Hand-Offs">
      <rule>State which archive skill is selected and what artifact will be produced.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Classify Archive Need">
      <question>Need symbol index/navigation? Route to archive-code.</question>
      <question>Need semantic document retrieval? Route to archive-docs.</question>
      <question>Need repository evolution/history? Route to archive-git.</question>
      <question>Need structural code graph? Route to archive-graph.</question>
      <question>Need durable decision/context store? Route to archive-memory.</question>
    </step>

    <step number="2" name="Dispatch to Specialized Skill">
      <decision_tree>
        <branch condition="Code symbol navigation">archive-code</branch>
        <branch condition="Document embedding and semantic search">archive-docs</branch>
        <branch condition="Git history or commit tracing">archive-git</branch>
        <branch condition="Structural node/edge code graph">archive-graph</branch>
        <branch condition="Persistent key/value memory context">archive-memory</branch>
      </decision_tree>
    </step>

    <step number="3" name="Record Archive Contract">
      <instruction>Capture chosen skill, project path, output path, and retrieval command.</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Use archive-code and archive-graph together for deep structural analysis</do>
    <do>Use archive-memory for decisions and archive-docs for long-form references</do>
    <do>Pair archive-git with other archives when validating historical context</do>
    <dont>Store the same payload redundantly in every archive store</dont>
    <dont>Route to multiple archive skills before clarifying retrieval intent</dont>
  </best_practices>

  <related_skills>
    <skill>archive-code</skill>
    <skill>archive-docs</skill>
    <skill>archive-git</skill>
    <skill>archive-graph</skill>
    <skill>archive-memory</skill>
  </related_skills>
</skill>
