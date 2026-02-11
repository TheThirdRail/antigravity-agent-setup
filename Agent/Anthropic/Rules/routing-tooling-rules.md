---
name: routing-tooling-rules
description: |
  Unified routing and tool selection policy.
  Consolidates workflow_router and tool_selection_rules.
activation: always_on
---

<rule name="routing-tooling-rules" version="1.1.0">
  <metadata>
    <category>routing</category>
    <severity>info</severity>
  </metadata>

  <goal>Select the right execution mode and tool for each request intent with clear fallback behavior.</goal>

  <routing_baseline>
    <rule>When intent clearly matches a known workflow/subagent trigger, recommend that route first.</rule>
    <rule>User may decline routing and continue with direct execution.</rule>
    <rule>Legacy workflow commands are compatibility-only; Anthropic subagents are canonical.</rule>
    <rule>Route `/tutor` only when the user explicitly requests extra learning or explanation support.</rule>
    <rule>For implementation/debug/review flows, keep explanations concise and define unfamiliar terms inline without auto-routing to `/tutor`.</rule>
  </routing_baseline>

  <intent_routing_matrix>
    <route trigger="Idea/Brainstorming" subagent="/architect" />
    <route trigger="Planning/Design" subagent="/architect" />
    <route trigger="Debugging/Issues" subagent="/analyze" />
    <route trigger="Surgical Debugging" subagent="/fix-issue" mode="surgical" />
    <route trigger="Implementation" subagent="/code" />
    <route trigger="Researching" subagent="/research" />
    <route trigger="Learning/Docs" subagent="/tutor" gate="explicit_user_request_only" />
    <route trigger="Project Setup" subagent="/project-setup" />
    <route trigger="Refactoring" subagent="/refactor" />
    <route trigger="Pull Request" subagent="/pr" />
    <route trigger="Testing/TDD" subagent="/test-developer" />
    <route trigger="Security Audit" subagent="/security-audit" />
    <route trigger="Fix Issue" subagent="/fix-issue" />
    <route trigger="Handoff" subagent="/handoff" />
    <route trigger="Morning Routine" subagent="/morning" />
    <route trigger="New Codebase" subagent="/onboard" />
    <route trigger="Dependency Check" subagent="/dependency-check" />
    <route trigger="Deployment" subagent="/deploy" />
    <route trigger="Performance Optimization" subagent="/performance-tune" />
    <route trigger="Code Review" subagent="/review" />
  </intent_routing_matrix>

  <capability_equivalents>
    <equivalent capability="task-router">Provided by this rule file via the deterministic `intent_routing_matrix` and `fallback_protocol`.</equivalent>
    <equivalent capability="quality-gates">Provided by `engineering-quality-rules.md` plus `/review`, `/test-developer`, and `/refactor` subagents.</equivalent>
    <equivalent capability="context-governance">Provided by `governance-context-rules.md` plus `archive-manager` routing.</equivalent>
  </capability_equivalents>

  <tool_selection_matrix>
    <tier type="quick-facts">Prefer low-latency web search for simple confirmations.</tier>
    <tier type="question-answering">Prefer synthesis-capable research tools for technical Q&amp;A.</tier>
    <tier type="documentation-ingestion">Prefer direct fetch for single pages, escalate to crawl tools for dynamic/multi-page docs.</tier>
    <tier type="broad-discovery">Prefer semantic discovery tools for alternatives and ecosystem exploration.</tier>
    <tier type="complex-scraping">Prefer robust scraping actors; browser automation is fallback when necessary.</tier>
  </tool_selection_matrix>

  <fallback_protocol>
    <step>Identify primary user intent first.</step>
    <step>Select preferred tool for that intent.</step>
    <step>If preferred tool fails, log reason and use documented fallback.</step>
    <step>If still uncertain, use a general-purpose research tool and disclose uncertainty.</step>
  </fallback_protocol>
</rule>
