---
name: fix-issue
description: |
  Fix a GitHub issue - analyze, implement, test, and create PR
---

<subagent name="fix-issue" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Fix a GitHub issue - analyze, implement, test, and create PR</purpose>

  <when_to_use>
    <trigger>When assigned a GitHub issue</trigger>
    <trigger>When picking up a bug report</trigger>
    <trigger>Usage: /fix-issue 123 where 123 is the issue number</trigger>
    <trigger>For surgical debugging: /fix-issue surgical (skip branch/PR)</trigger>
  </when_to_use>

  <required_input>
    <item>If the required argument is missing, ask for it before proceeding (`&lt;issue-number&gt;`).</item>
  </required_input>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Fetch Issue Details">
      <action>Read the issue description</action>
      <action>Check comments for additional context</action>
      <action>Look at any linked issues or PRs</action>
    </step>
    <step number="2" name="Create a Branch">
      <action>Run `git checkout main`</action>
      <action>Run `git pull`</action>
      <action>Run `git checkout -b fix/issue-$ARGUMENTS`</action>
    </step>
    <step number="3" name="Reproduce the Problem">
      <action>Follow the reproduction steps</action>
      <action>Understand when it happens</action>
      <action>Note expected vs actual behavior</action>
    </step>
    <step number="4" name="Find the Cause">
      <action>Search for relevant files</action>
      <action>Add logging if needed</action>
      <action>Identify the root cause (not just symptoms)</action>
    </step>
    <step number="5" name="Plan the Fix">
      <action>What changes are needed?</action>
      <action>Any side effects to watch for?</action>
      <action>Keep the fix minimal and focused</action>
    </step>
    <step number="6" name="Write a Test">
      <action>Use skill `test-generator`: Use for creating regression test</action>
      <action>Write a test that fails with the bug</action>
      <action>This prevents regression later</action>
    </step>
    <step number="7" name="Implement the Fix">
      <action>Follow existing code style</action>
      <action>Keep changes minimal</action>
      <action>Comment non-obvious decisions</action>
    </step>
    <step number="8" name="Run Tests">
      <action>Run `npm test`</action>
    </step>
    <step number="9" name="Update Archives">
      <action>Use skill `archive-manager`: Route and execute archive updates for changed code/docs before completion</action>
      <action>Refresh archive-code/archive-docs/archive-graph/archive-memory for modified artifacts</action>
    </step>
    <step number="10" name="Commit with Reference">
      <action>Use skill `git-commit-generator`: Use for conventional commit message</action>
      <action>Run `git add .`</action>
      <action>Run `git commit -m &quot;fix: [description] Fixes #$ARGUMENTS&quot;`</action>
    </step>
    <step number="11" name="Create PR">
      <action>Reference the issue in the PR</action>
      <action>Explain what was wrong and how it was fixed</action>
      <action>Use /pr workflow if needed</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>Issue is reproducible (before fix)</criterion>
    <criterion>Issue is resolved (after fix)</criterion>
    <criterion>Test added to prevent regression</criterion>
    <criterion>All existing tests pass</criterion>
    <criterion>PR created and linked to issue</criterion>
  </output_contract>

  <handoffs>
    <route>/pr</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

