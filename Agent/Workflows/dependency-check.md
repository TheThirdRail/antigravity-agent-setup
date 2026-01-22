---
description: Check for outdated or vulnerable dependencies and update them safely
---

<workflow name="dependency-check" thinking="Normal">
  <when_to_use>
    <trigger>Monthly maintenance</trigger>
    <trigger>Before major releases</trigger>
    <trigger>After security advisories</trigger>
    <trigger>When things mysteriously break</trigger>
  </when_to_use>

  <steps>
    <step number="1" name="Check for Vulnerabilities" turbo="true">
      <command>npm audit</command>
    </step>

    <step number="2" name="Check for Outdated Packages" turbo="true">
      <command>npm outdated</command>
    </step>

    <step number="3" name="Review the Results">
      <category severity="Critical/High">Update immediately</category>
      <category severity="Medium">Update soon</category>
      <category severity="Low">Update when convenient</category>
      <category severity="Major versions">Review changelog first!</category>
    </step>

    <step number="4" name="Update Safe Packages First" turbo="true">
      <instruction>Patch and minor versions</instruction>
      <command>npm update</command>
    </step>

    <step number="5" name="Handle Major Updates Carefully">
      <action>Read the changelog/migration guide</action>
      <action>Update one package</action>
      <action>Run tests</action>
      <action>Commit if passing</action>
    </step>

    <step number="6" name="Run Full Test Suite" turbo="true">
      <command>npm test</command>
    </step>

    <step number="7" name="Document Changes">
      <action>List updated packages</action>
      <action>Note any breaking changes handled</action>
      <action>Commit with clear message</action>
    </step>
  </steps>

  <success_criteria>
    <criterion>No critical vulnerabilities</criterion>
    <criterion>No high vulnerabilities</criterion>
    <criterion>Major updates reviewed individually</criterion>
    <criterion>All tests pass after updates</criterion>
    <criterion>Changes committed</criterion>
  </success_criteria>
</workflow>
