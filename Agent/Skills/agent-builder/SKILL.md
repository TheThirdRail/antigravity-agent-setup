---
name: agent-builder
description: |
  Meta-skill for extending Antigravity's capabilities. Acts as a router
  to help users build Skills, Workflows, Rules, or MCP Tools.
  Use when the user wants to "add something" to the agent or "teach" it new tricks
  but hasn't specified exactly which component type to create.
---

<skill name="agent-builder" version="1.0.0">
  <metadata>
    <keywords>build, create, extend, skill, workflow, rule, tool, mcp</keywords>
  </metadata>

  <goal>Guide the user to the correct builder skill for extending Antigravity's capabilities.</goal>

  <when_to_use>
    <trigger>User wants to "teach" the agent something new</trigger>
    <trigger>User wants to "add a capability" but is vague about implementation</trigger>
    <trigger>Unsure whether to build a Skill, Workflow, or MCP Tool</trigger>
  </when_to_use>

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

  <related_skills>
    <skill>skill-builder</skill>
    <skill>workflow-builder</skill>
    <skill>rule-builder</skill>
    <skill>mcp-builder</skill>
    <skill>mcp-manager</skill>
  </related_skills>
</skill>
