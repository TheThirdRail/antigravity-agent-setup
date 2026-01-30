---
description: Fix a GitHub issue - analyze, implement, test, and create PR
argument-hint: <issue-number>
---

<workflow name="fix-issue" thinking="Normal">
  <when_to_use>
    <trigger>When assigned a GitHub issue</trigger>
    <trigger>When picking up a bug report</trigger>
    <trigger>Usage: /fix-issue 123 where 123 is the issue number</trigger>
  </when_to_use>

  <recommended_mcp>
    <server>github</server>
    <reason>Link fixes to issues automatically</reason>
  </recommended_mcp>

  <steps>
    <step number="1" name="Fetch Issue Details">
      <action>Read the issue description</action>
      <action>Check comments for additional context</action>
      <action>Look at any linked issues or PRs</action>
    </step>

    <step number="2" name="Create a Branch">
      <command>git checkout main</command>
      <command>git pull</command>
      <command>git checkout -b fix/issue-$ARGUMENTS</command>
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
      <question>What changes are needed?</question>
      <question>Any side effects to watch for?</question>
      <instruction>Keep the fix minimal and focused</instruction>
    </step>

    <step number="6" name="Write a Test">
      <skill ref="test-generator">Use for creating regression test</skill>
      <instruction>Write a test that fails with the bug</instruction>
      <instruction>This prevents regression later</instruction>
    </step>

    <step number="7" name="Implement the Fix">
      <action>Follow existing code style</action>
      <action>Keep changes minimal</action>
      <action>Comment non-obvious decisions</action>
    </step>

    <step number="8" name="Run Tests" turbo="true">
      <command>npm test</command>
    </step>

    <step number="9" name="Commit with Reference">
      <skill ref="git-commit-generator">Use for conventional commit message</skill>
      <command>git add .</command>
      <command>git commit -m "fix: [description]

Fixes #$ARGUMENTS"</command>
    </step>

    <step number="10" name="Create PR">
      <action>Reference the issue in the PR</action>
      <action>Explain what was wrong and how it was fixed</action>
      <action>Use /pr workflow if needed</action>
    </step>
  </steps>

  <success_criteria>
    <criterion>Issue is reproducible (before fix)</criterion>
    <criterion>Issue is resolved (after fix)</criterion>
    <criterion>Test added to prevent regression</criterion>
    <criterion>All existing tests pass</criterion>
    <criterion>PR created and linked to issue</criterion>
  </success_criteria>
</workflow>
