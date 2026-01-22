---
name: skill-builder
description: |
  Meta-skill for creating new AI agent skills following best practices. Guides
  the process of defining skill structure, writing effective YAML frontmatter,
  crafting discoverable descriptions, and organizing resources. Produces skills
  compatible with Claude Code, GitHub Copilot, Cursor, and Antigravity.
---

<skill name="skill-builder" version="1.0.0">
  <metadata>
    <keywords>skills, meta, template, builder, creation</keywords>
  </metadata>

  <goal>Guide creation of AI agent skills with progressive disclosure, clear descriptions, and proper structure.</goal>

  <core_principles>
    <principle name="Progressive Disclosure">
      <level name="Metadata" tokens="~50">Name + description loaded at startup</level>
      <level name="Instructions" tokens="~2-5K">Full SKILL.md when activated</level>
      <level name="Resources" tokens="variable">Scripts/examples loaded on-demand</level>
    </principle>

    <principle name="Single Responsibility">
      <rule>One skill = one capability</rule>
      <rule>If scope creeps, split into multiple skills</rule>
      <rule>Skills can reference other skills for composition</rule>
    </principle>

    <principle name="Discovery-First Design">
      <rule>Description must explain WHEN to use (not just what)</rule>
      <rule>Include trigger conditions</rule>
      <rule>Use keywords for searchability</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Define the Skill">
      <question>What capability does this skill provide?</question>
      <question>When should an agent use this skill?</question>
      <question>What triggers would activate this skill?</question>
      <question>What inputs does it need?</question>
      <question>What outputs does it produce?</question>
    </step>

    <step number="2" name="Create Folder Structure">
      <structure><![CDATA[
.agent/skills/<skill-name>/
├── SKILL.md          # Required: Main instructions
├── scripts/          # Optional: Helper scripts
├── examples/         # Optional: Usage examples
└── resources/        # Optional: Templates, assets
      ]]></structure>
      <naming>Use kebab-case: git-commit-generator, max 64 chars</naming>
    </step>

    <step number="3" name="Write SKILL.md File">
      <format>Embedded XML in Markdown (YAML frontmatter + XML body)</format>
      <template><![CDATA[
---
name: skill-name
description: |
  Brief description of what the skill does.
  Include WHEN to use this skill (triggers).
  Keep under 200 words.
---

<skill name="skill-name" version="1.0.0">
  <metadata>
    <keywords>keyword1, keyword2, keyword3</keywords>
  </metadata>

  <goal>One sentence describing the skill's purpose.</goal>

  <core_principles>
    <principle name="Key Principle">
      <rule>Specific rule or guideline</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Step Name">
      <instruction>What to do in this step</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>What to do</do>
    <dont>What to avoid</dont>
  </best_practices>
</skill>
      ]]></template>
      <note>The YAML frontmatter is for discovery; the XML body contains structured instructions</note>
    </step>

    <step number="4" name="Write Skill Body">
      <sections>
        <section>Goal - One sentence</section>
        <section>Core Principles - Key rules</section>
        <section>When To Use - Trigger conditions</section>
        <section>Workflow Instructions - Step-by-step</section>
        <section>Decision Tree - For complex logic</section>
        <section>Examples - Input → Output format</section>
        <section>Best Practices - DO/DON'T lists</section>
        <section>Related Skills - Cross-references</section>
      </sections>
    </step>

    <step number="5" name="Add Supporting Files">
      <instruction>Keep references one level deep (agent may not read deeply nested files)</instruction>
    </step>

    <step number="6" name="Validate">
      <checklist>
        <item>YAML frontmatter is valid</item>
        <item>Description explains when to use</item>
        <item>Goal section is clear and concise</item>
        <item>Instructions are actionable</item>
        <item>Examples show input → output</item>
        <item>DO/DON'T lists provide guardrails</item>
      </checklist>
    </step>
  </workflow>

  <platform_compatibility>
    <platform name="Antigravity" location=".agent/skills/"/>
    <platform name="Claude Code" location=".claude/skills/"/>
    <platform name="GitHub Copilot" location=".github/skills/"/>
    <platform name="Cursor" location=".cursor/skills/"/>
  </platform_compatibility>

  <best_practices>
    <do>Keep SKILL.md as the "reception desk" pointing to resources</do>
    <do>Write descriptions that explain WHEN to use (triggers)</do>
    <do>Include decision trees for complex branching</do>
    <do>Provide concrete examples</do>
    <do>Use tables for quick reference data</do>
    <do>Keep references one level deep</do>
    <dont>Put everything in one massive file</dont>
    <dont>Write vague descriptions ("Does stuff")</dont>
    <dont>Create mega-skills</dont>
    <dont>Skip the "When to use" section</dont>
    <dont>Deeply nest file references</dont>
  </best_practices>

  <troubleshooting>
    <issue problem="Skill not discovered">Check description explains WHEN to use</issue>
    <issue problem="Skill partially loaded">Keep references one level deep</issue>
    <issue problem="Wrong skill activated">Make description more specific</issue>
    <issue problem="Instructions ignored">Use numbered steps, not prose</issue>
  </troubleshooting>

  <related_skills>
    <skill>mcp-manager</skill>
    <skill>docker-ops</skill>
    <skill>tool-creator</skill>
  </related_skills>
</skill>
