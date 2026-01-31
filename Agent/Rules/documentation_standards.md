---
name: documentation-standards
description: |
  Enforce documentation minimums across all work. Every feature needs docs,
  public APIs need docstrings, and architecture decisions require ADRs.
activation: always_on
---

<rule name="documentation-standards" version="1.0.0">
  <metadata>
    <category>quality</category>
    <severity>warning</severity>
  </metadata>

  <goal>Ensure all code and features are properly documented for maintainability.</goal>

  <requirements>
    <requirement name="Feature Documentation" severity="error">
      Every new feature or significant change MUST have accompanying documentation updates.
      <examples>
        <example>New API endpoint → Update README API section</example>
        <example>New component → Add usage examples</example>
        <example>New workflow → Document in Agent/Workflows/</example>
      </examples>
    </requirement>

    <requirement name="Public API Documentation" severity="error">
      All public functions, classes, and methods MUST have docstrings/JSDoc.
      <format language="typescript">
        /**
         * Brief description of purpose.
         * @param paramName - Description of parameter
         * @returns Description of return value
         * @throws Description of when errors are thrown
         * @example
         * const result = myFunction(input);
         */
      </format>
      <format language="python">
        """
        Brief description of purpose.

        Args:
            param_name: Description of parameter

        Returns:
            Description of return value

        Raises:
            ErrorType: When this error is thrown

        Example:
            result = my_function(input)
        """
      </format>
    </requirement>

    <requirement name="Comment Philosophy" severity="warning">
      <do>Explain WHY the code exists, not WHAT it does</do>
      <do>Document non-obvious decisions and trade-offs</do>
      <do>Explain complex algorithms or business logic</do>
      <dont>State the obvious (e.g., "increment counter")</dont>
      <dont>Leave outdated comments when code changes</dont>
    </requirement>

    <requirement name="Architecture Decision Records" severity="warning">
      Major technical decisions SHOULD be documented in ADRs.
      <triggers>
        <trigger>Choosing a framework or library</trigger>
        <trigger>Significant architectural changes</trigger>
        <trigger>Security-related decisions</trigger>
        <trigger>Performance trade-offs</trigger>
      </triggers>
      <format>
        # ADR-NNN: [Decision Title]
        
        ## Status
        Proposed | Accepted | Deprecated | Superseded
        
        ## Context
        What is the issue we're seeing that motivates this decision?
        
        ## Decision
        What is the change we're proposing?
        
        ## Consequences
        What becomes easier or harder after this change?
      </format>
    </requirement>

    <requirement name="README Maintenance" severity="warning">
      README.md MUST be updated when:
      <condition>Adding major features</condition>
      <condition>Changing installation or setup steps</condition>
      <condition>Modifying environment variables</condition>
      <condition>Adding or removing dependencies</condition>
    </requirement>
  </requirements>

  <enforcement>
    <check trigger="before_commit">
      Verify new public APIs have documentation
    </check>
    <check trigger="before_pr">
      Verify README reflects current functionality
    </check>
  </enforcement>

  <related_rules>
    <rule>testing_rules</rule>
    <rule>code_standards</rule>
  </related_rules>
</rule>
