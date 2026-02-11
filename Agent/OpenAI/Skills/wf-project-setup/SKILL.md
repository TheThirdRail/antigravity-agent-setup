---
name: wf-project-setup
description: |
  OpenAI Codex orchestration skill converted from `project-setup.md`.
  Use when After /architect has created prd.md, checklist.md; Before starting /code implementation; To set up file structure and configuration.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-project-setup" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, project-setup, openai, codex</keywords>
    <source_workflow>project-setup.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-project-setup</id>
    <name>wf-project-setup</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Project Setup - Initialize project structure after Architect Mode planning</purpose>
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

  <goal>Project Setup - Initialize project structure after Architect Mode planning</goal>

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
    <step number="1" name="Create .gitignore">
      <instruction># Dependencies node_modules/ vendor/ .venv/ __pycache__/ # Build outputs dist/ build/ .next/ # Environment .env .env.local .env.*.local # IDE .idea/ .vscode/settings.json # AI/Agent Generated (DO NOT COMMIT) Agent-Context/ # Archive Data (DO NOT COMMIT) Agent-Context/Archives/ Archive/ # Testing coverage/ # Temporary tmp/ temp/</instruction>
    </step>
    <step number="2" name="Create Agent-Context Folder Structure">
      <instruction>Create the Agent-Context directory tree for all agent-generated files. Agent-Context/Research Agent-Context/Lessons Agent-Context/PRD Agent-Context/Plan Agent-Context/Tasks Agent-Context/Communications/Agent-Notes Agent-Context/Communica...</instruction>
    </step>
    <step number="3" name="Create Project Structure">
      <instruction>Use for structure decisions Based on the tech stack from /architect, create appropriate folders src/components/, src/pages/, src/utils/, public/, tests/, docs/ src/, tests/, docs/, scripts/</instruction>
    </step>
    <step number="4" name="Generate Workspace Rules">
      <instruction>Use to create project-specific rules Create `.agent/rules/project-rules.md` using the rule-builder format --- name: project-rules description: | Workspace-specific rules for this project. Includes stack conventions and testing requiremen...</instruction>
    </step>
    <step number="5" name="Initialize Git">
      <instruction>git init git add . git commit -m "Initial project setup"</instruction>
      <command>git init</command>
      <command>git add .</command>
      <command>git commit -m "Initial project setup"</command>
    </step>
    <step number="6" name="Create README.md">
      <instruction>Project name and description (from prd.md) Installation instructions Usage examples Contributing guidelines</instruction>
    </step>
    <step number="7" name="Prepare for Implementation">
      <instruction>Inform user that project is ready Suggest proceeding with /code workflow</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `architecture-planner` when that capability is required.</do>
    <do>Invoke related skill `rule-builder` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>architecture-planner</skill>
    <skill>rule-builder</skill>
  </related_skills>
</skill>
