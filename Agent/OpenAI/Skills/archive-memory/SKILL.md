---
name: archive-memory
description: |
  Persist structured project context in a local SQLite memory store. Use when
  recording decisions, patterns, and durable notes that should survive across
  sessions and remain queryable by category or text search.
---

<skill name="archive-memory" version="2.0.0">
  <metadata>
    <keywords>archive, memory, sqlite, context, decisions, persistence</keywords>
  </metadata>

  <spec_contract>
    <id>archive-memory</id>
    <name>archive-memory</name>
    <version>2.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Maintain durable project memory with safe, parameterized read/write/delete operations.</purpose>
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

  <goal>Maintain durable project memory with safe, parameterized read/write/delete operations.</goal>

  <core_principles>
    <principle name="Python as Canonical Implementation">
      <rule>Python scripts are the source of truth for archive-memory behavior.</rule>
      <rule>PowerShell scripts are wrappers that delegate to Python scripts.</rule>
    </principle>

    <principle name="Safe Persistence">
      <rule>Use parameterized SQL paths only; avoid raw SQL interpolation in wrappers.</rule>
      <rule>Store memory at [PROJECT_PATH]/Agent-Context/Archives/memory.db.</rule>
    </principle>

    <principle name="Structured Retrieval">
      <rule>Support targeted reads by category/key plus broad keyword search.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Write Memory Entry">
      <command>python Agent\OpenAI\Skills\archive-memory\scripts\write.py --category "decisions" --key "auth-strategy" --value "JWT with refresh tokens" --project-path "[PROJECT_PATH]"</command>
      <note>Valid categories: decisions, patterns, files, context, custom.</note>
    </step>

    <step number="2" name="Read Memory">
      <command>python Agent\OpenAI\Skills\archive-memory\scripts\read.py --category "decisions" --key "auth-strategy" --project-path "[PROJECT_PATH]"</command>
      <command>python Agent\OpenAI\Skills\archive-memory\scripts\read.py --search "auth" --project-path "[PROJECT_PATH]"</command>
    </step>

    <step number="3" name="Delete Memory Entry">
      <command>python Agent\OpenAI\Skills\archive-memory\scripts\delete.py --category "decisions" --key "auth-strategy" --project-path "[PROJECT_PATH]"</command>
    </step>

    <step number="4" name="Use Wrapper Commands When Needed">
      <command>.\Agent\OpenAI\Skills\archive-memory\scripts\write.ps1 -Category decisions -Key "auth-strategy" -Value "JWT with refresh tokens" -ProjectPath "[PROJECT_PATH]"</command>
      <instruction>Wrappers delegate to Python for consistent behavior and safety.</instruction>
    </step>
  </workflow>

  <resources>
    <script file="scripts/write.py">Canonical write/upsert operation.</script>
    <script file="scripts/read.py">Canonical read/search operation.</script>
    <script file="scripts/delete.py">Canonical delete operation.</script>
    <script file="scripts/write.ps1">PowerShell wrapper for write.py.</script>
    <script file="scripts/read.ps1">PowerShell wrapper for read.py.</script>
    <script file="scripts/delete.ps1">PowerShell wrapper for delete.py.</script>
  </resources>

  <best_practices>
    <do>Store concise keys and meaningful values with stable category usage</do>
    <do>Use project-path explicitly when operating outside project root</do>
    <do>Capture decisions with rationale, not only conclusions</do>
    <dont>Store credentials or sensitive secrets in memory archives</dont>
    <dont>Use wrappers to execute raw SQL directly</dont>
  </best_practices>

  <related_skills>
    <skill>archive-manager</skill>
    <skill>research-capability</skill>
    <skill>documentation-generator</skill>
  </related_skills>
</skill>
