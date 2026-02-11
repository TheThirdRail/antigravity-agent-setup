---
name: pr
description: |
  Create a pull request with proper description, tests verified, and ready for review
---

<subagent name="pr" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Create a pull request with proper description, tests verified, and ready for review</purpose>

  <when_to_use>
    <trigger>When code is ready for review</trigger>
    <trigger>When a feature or fix is complete</trigger>
    <trigger>Before merging to main branch</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Verify Tests Pass">
      <action>Run `npm test`</action>
    </step>
    <step number="2" name="Run Linter">
      <action>Run `npm run lint`</action>
    </step>
    <step number="3" name="Check What&apos;s Changed">
      <action>Run `git diff main --stat`</action>
    </step>
    <step number="4" name="Clean Up Commits">
      <action>Combine &quot;WIP&quot; commits</action>
      <action>Write clear commit messages</action>
      <action>Each commit should be meaningful</action>
    </step>
    <step number="5" name="Push Branch">
      <action>Run `git push -u origin HEAD`</action>
    </step>
    <step number="6" name="Generate PR Description">
      <action>## What [Brief description of what this PR does] ## Why [Why this change is needed - link to issue if applicable] ## How [How the change works, key implementation details] ## Testing - [ ] Unit tests added/updated - [ ] Manual testing completed - [ ] Edge cases covered ## Screenshots (if UI changes) [Add screenshots here]</action>
    </step>
    <step number="7" name="Create the PR">
      <action>Use the generated description</action>
      <action>Add appropriate labels</action>
      <action>Request reviewers</action>
    </step>
    <step number="8" name="Self-Review">
      <action>Use skill `code-reviewer`: Use for systematic self-review</action>
      <action>Review the diff in the PR interface</action>
      <action>Check for accidental debug code</action>
      <action>Verify no secrets are exposed</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>All tests pass</criterion>
    <criterion>Linter passes</criterion>
    <criterion>PR description explains what/why/how</criterion>
    <criterion>Reviewers assigned</criterion>
    <criterion>No debug code or secrets</criterion>
  </output_contract>

  <handoffs>
    <route>/analyze</route>
    <route>/architect</route>
    <route>/code</route>
    <route>/dependency-check</route>
    <route>/deploy</route>
    <route>/fix-issue</route>
    <route>/handoff</route>
    <route>/morning</route>
    <route>/onboard</route>
    <route>/performance-tune</route>
    <route>/project-setup</route>
    <route>/refactor</route>
    <route>/research</route>
    <route>/review</route>
    <route>/security-audit</route>
    <route>/test-developer</route>
    <route>/tutor</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

