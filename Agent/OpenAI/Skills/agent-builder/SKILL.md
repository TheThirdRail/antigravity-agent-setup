---
name: agent-builder
description: |
  Meta-skill for extending Antigravity's capabilities. Acts as a router
  to help users build Skills, Workflows, Rules, or MCP Tools.
  Use when the user wants to "add something" to the agent or "teach" it new tricks
  but hasn't specified exactly which component type to create.
---

<skill name="agent-builder" version="2.0.0">
  <metadata>
    <keywords>build, create, extend, skill, workflow, rule, tool, mcp</keywords>
  </metadata>

  <spec_contract>
    <id>agent-builder</id>
    <name>agent-builder</name>
    <version>2.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Guide the user to the correct builder skill for extending Antigravity&apos;s capabilities.</purpose>
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

  <goal>Guide the user to the correct builder skill for extending Antigravity's capabilities.</goal>

  <core_principles>
    <principle name="Route Before Building">
      <rule>Ask minimal clarifying questions, then route to one primary builder skill.</rule>
      <rule>Avoid mixing build tracks unless the user explicitly requests composition.</rule>
    </principle>

    <principle name="Prefer Existing Capability">
      <rule>Use mcp-manager to discover existing capabilities before routing to mcp-builder.</rule>
      <rule>Treat custom MCP construction as a last resort.</rule>
    </principle>

    <principle name="Keep Handoffs Explicit">
      <rule>State which builder skill is selected and why.</rule>
      <rule>Keep handoff criteria concrete so the target builder can execute immediately.</rule>
    </principle>
  </core_principles>

  <decision_tree>
    <node id="start" question="What kind of capability do you want to add?">
      <branch answer="Reusable knowledge/instructions" target="skill-builder">
        <description>Best for: "How-to" guides, procedural knowledge, specialized tech stacks</description>
      </branch>
      
      <branch answer="Step-by-step process" target="workflow-builder">
        <description>Best for: Checklists, multi-step procedures, standard operating procedures</description>
      </branch>
      
      <branch answer="Behavioral constraint" target="rule-builder">
        <description>Best for: "Always do X", "Never do Y", style guides, safety rails</description>
      </branch>
      
      <branch answer="New functional ability" target="mcp-tool-decision">
        <description>Best for: Executing code, API calls, system operations</description>
      </branch>
    </node>

    <node id="mcp-tool-decision" question="Does the functionality already exist in an MCP server?">
      <branch answer="Yes / Maybe" target="mcp-manager">
        <action>Use mcp-manager to Find/Add existing servers</action>
      </branch>
      
      <branch answer="Yes, but I want to combine tools" target="mcp-manager">
        <action>Use mcp-manager code-mode feature</action>
      </branch>
      
      <branch answer="No, I need to build it from scratch" target="mcp-builder">
        <action>Create a custom MCP tool</action>
      </branch>
    </node>
  </decision_tree>

  <workflow>
    <step number="1" name="Identify Need">
      <instruction>Ask clarifying questions to determine the nature of the capability.</instruction>
      <example>"Are you trying to teach me a process (Workflow), a concept (Skill), or give me a new tool (MCP)?"</example>
    </step>

    <step number="2" name="Route to Builder">
      <instruction>Invoke the appropriate sub-skill based on determination.</instruction>
      
      <case condition="Skill">
        <action>Execute skill-builder</action>
      </case>
      
      <case condition="Workflow">
        <action>Execute workflow-builder</action>
      </case>
      
      <case condition="Rule">
        <action>Execute rule-builder</action>
      </case>
      
      <case condition="MCP Tool">
        <action>Execute mcp-builder</action>
      </case>
    </step>
  </workflow>

  <best_practices>
    <do>Route to one builder skill when the request maps cleanly</do>
    <do>Use mcp-manager before mcp-builder for capability discovery</do>
    <do>Reframe vague requests into concrete output goals</do>
    <dont>Start implementing before the capability type is identified</dont>
    <dont>Assume custom tooling is needed without checking existing options</dont>
  </best_practices>

  <related_skills>
    <skill>skill-builder</skill>
    <skill>workflow-builder</skill>
    <skill>rule-builder</skill>
    <skill>mcp-builder</skill>
    <skill>mcp-manager</skill>
  </related_skills>
</skill>
