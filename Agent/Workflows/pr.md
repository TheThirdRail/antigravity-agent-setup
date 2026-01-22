---
description: Create a pull request with proper description, tests verified, and ready for review
---

<workflow name="pr" thinking="Normal">
  <when_to_use>
    <trigger>When code is ready for review</trigger>
    <trigger>When a feature or fix is complete</trigger>
    <trigger>Before merging to main branch</trigger>
  </when_to_use>

  <steps>
    <step number="1" name="Verify Tests Pass" turbo="true">
      <command>npm test</command>
    </step>

    <step number="2" name="Run Linter" turbo="true">
      <command>npm run lint</command>
    </step>

    <step number="3" name="Check What's Changed" turbo="true">
      <command>git diff main --stat</command>
    </step>

    <step number="4" name="Clean Up Commits" optional="true">
      <action>Combine "WIP" commits</action>
      <action>Write clear commit messages</action>
      <action>Each commit should be meaningful</action>
    </step>

    <step number="5" name="Push Branch" turbo="true">
      <command>git push -u origin HEAD</command>
    </step>

    <step number="6" name="Generate PR Description">
      <template><![CDATA[
## What
[Brief description of what this PR does]

## Why
[Why this change is needed - link to issue if applicable]

## How
[How the change works, key implementation details]

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] Edge cases covered

## Screenshots (if UI changes)
[Add screenshots here]
      ]]></template>
    </step>

    <step number="7" name="Create the PR">
      <action>Use the generated description</action>
      <action>Add appropriate labels</action>
      <action>Request reviewers</action>
    </step>

    <step number="8" name="Self-Review">
      <action>Review the diff in the PR interface</action>
      <action>Check for accidental debug code</action>
      <action>Verify no secrets are exposed</action>
    </step>
  </steps>

  <success_criteria>
    <criterion>All tests pass</criterion>
    <criterion>Linter passes</criterion>
    <criterion>PR description explains what/why/how</criterion>
    <criterion>Reviewers assigned</criterion>
    <criterion>No debug code or secrets</criterion>
  </success_criteria>
</workflow>
