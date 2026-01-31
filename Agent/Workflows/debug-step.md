---
description: Surgical step-by-step debugging for specific errors
---

<workflow name="debug-step" thinking="MAX">
  <metadata>
    <description>Interactive step-by-step debugging for isolating and fixing specific errors</description>
  </metadata>

  <important>Use MAXIMUM thinking/reasoning depth. Follow the error methodically.</important>

  <when_to_use>
    <trigger>Encountering a specific error message</trigger>
    <trigger>Test failing for unknown reason</trigger>
    <trigger>Unexpected behavior in specific code path</trigger>
    <trigger>Need to trace execution step-by-step</trigger>
  </when_to_use>

  <distinction>
    <versus workflow="/analyze">
      <difference>/analyze is for BROAD problem diagnosis with hypotheses</difference>
      <difference>/debug-step is for SURGICAL isolation of specific errors</difference>
      <difference>/analyze generates ranked cause lists; /debug-step traces execution</difference>
    </versus>
  </distinction>

  <steps>
    <step number="1" name="Capture the Error">
      <instruction>Document the exact error and context</instruction>
      <actions>
        <action>Copy exact error message and stack trace</action>
        <action>Note what action triggered the error</action>
        <action>Record environment details (browser, Node version, etc.)</action>
      </actions>
      <output>Clear error description with reproduction context</output>
    </step>

    <step number="2" name="Create Minimal Reproduction">
      <instruction>Isolate the error to smallest possible case</instruction>
      <actions>
        <action>Strip away unrelated code</action>
        <action>Create a minimal test case that reproduces the error</action>
        <action>Verify the error occurs consistently</action>
      </actions>
      <question>Can you trigger this error in isolation?</question>
    </step>

    <step number="3" name="Add Strategic Debug Points">
      <instruction>Insert logging at key execution points</instruction>
      <locations>
        <location>Function entry (log inputs)</location>
        <location>Before conditional branches</location>
        <location>After async operations</location>
        <location>Before the error line</location>
        <location>Function exit (log outputs)</location>
      </locations>
      <format>
        console.log('[DEBUG step-name]:', { variable, anotherVariable });
      </format>
    </step>

    <step number="4" name="Execute and Capture">
      <instruction>Run the code and capture full debug output</instruction>
      <actions turbo="true">
        <action>Run the failing code/test</action>
        <action>Capture all console output</action>
        <action>Note the last successful log before failure</action>
      </actions>
    </step>

    <step number="5" name="Trace Execution Path">
      <instruction>Follow the logs to find where behavior diverges from expected</instruction>
      <questions>
        <question>What was the last successful step?</question>
        <question>What values were unexpected?</question>
        <question>Where did the code path diverge?</question>
      </questions>
      <output>Identified divergence point</output>
    </step>

    <step number="6" name="Identify Root Cause">
      <instruction>Pinpoint the exact line or condition causing the error</instruction>
      <analysis>
        <item>Why does this specific input cause failure?</item>
        <item>What assumption was violated?</item>
        <item>Is this a data issue, logic issue, or timing issue?</item>
      </analysis>
      <output>Root cause statement: "The error occurs because..."</output>
    </step>

    <step number="7" name="Propose Fix">
      <instruction>Suggest a specific code change to resolve the issue</instruction>
      <considerations>
        <item>Will this fix break other cases?</item>
        <item>Are there edge cases to handle?</item>
        <item>Should we add a test for this case?</item>
      </considerations>
      <output>Proposed code change with rationale</output>
    </step>

    <step number="8" name="Verify Fix">
      <instruction>Test the fix against original error and edge cases</instruction>
      <actions>
        <action>Apply the proposed fix</action>
        <action>Run the reproduction case</action>
        <action>Run related tests</action>
        <action>Test edge cases if applicable</action>
      </actions>
      <success>Original error no longer occurs</success>
    </step>

    <step number="9" name="Clean Up">
      <instruction>Remove debug artifacts and document</instruction>
      <actions>
        <action>Remove debug console.log statements</action>
        <action>Add a regression test if appropriate</action>
        <action>Update any relevant documentation</action>
        <action>Consider if similar bugs might exist elsewhere</action>
      </actions>
    </step>
  </steps>

  <interaction_pattern>
    After each step, confirm with user: "Does this match what you're seeing?"
    Adjust approach based on their feedback.
  </interaction_pattern>

  <success_criteria>
    <criterion>Root cause clearly identified</criterion>
    <criterion>Fix implemented and verified</criterion>
    <criterion>Original error no longer occurs</criterion>
    <criterion>No regressions introduced</criterion>
  </success_criteria>

  <related_workflows>
    <workflow>/analyze</workflow>
    <workflow>/fix-issue</workflow>
    <workflow>/test-developer</workflow>
  </related_workflows>
</workflow>
