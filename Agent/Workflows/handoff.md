---
description: End-of-session summary for handing off work to yourself tomorrow or a teammate
---

<workflow name="handoff" thinking="Normal">
  <when_to_use>
    <trigger>End of work session</trigger>
    <trigger>Before going on vacation</trigger>
    <trigger>Passing work to a teammate</trigger>
    <trigger>Any time you need to "save your mental state"</trigger>
  </when_to_use>

  <recommended_mcp>
    <server>shrimp-task-manager</server>
    <reason>Save session state and next steps</reason>
  </recommended_mcp>

  <steps>
    <step number="1" name="Summarize What Was Done">
      <question>What features were added?</question>
      <question>What bugs were fixed?</question>
      <question>What was changed?</question>
    </step>

    <step number="2" name="Identify What's In Progress">
      <question>What's partially complete?</question>
      <question>What was the approach being taken?</question>
      <question>Any dead ends hit?</question>
    </step>

    <step number="3" name="List Blockers">
      <question>Waiting on someone else?</question>
      <question>Need more information?</question>
      <question>Technical obstacle?</question>
    </step>

    <step number="4" name="Note Next Steps">
      <instruction>Numbered list of next actions in priority order</instruction>
    </step>

    <step number="5" name="Flag Any Gotchas">
      <example>"Don't run X without doing Y first"</example>
      <example>"This file is temporarily broken"</example>
      <example>"That approach didn't work because..."</example>
    </step>

    <step number="6" name="Check Branch State" turbo="true">
      <command>git status</command>
      <command>git log --oneline -5</command>
    </step>

    <step number="7" name="Create Handoff Document">
      <instruction>Write summary to HANDOFF.md or similar</instruction>
      <instruction>Include date/time</instruction>
      <instruction>Commit if appropriate</instruction>
    </step>
  </steps>

  <handoff_template><![CDATA[
# Handoff - [Date]

## Completed
- [x] Task 1
- [x] Task 2

## In Progress
- [ ] Task 3 (about 60% done)
  - Current approach: ...
  - Next step: ...

## Blockers
- Waiting on [person] for [thing]

## Next Steps
1. Finish task 3
2. Start task 4
3. Review PR #123

## Gotchas
- ⚠️ Don't merge PR #456 until #123 is done
- ⚠️ Tests in `auth.test.ts` are temporarily skipped
  ]]></handoff_template>

  <success_criteria>
    <criterion>All progress documented</criterion>
    <criterion>Next steps are clear</criterion>
    <criterion>Blockers are noted</criterion>
    <criterion>Someone else (or future you) can continue</criterion>
  </success_criteria>
</workflow>
