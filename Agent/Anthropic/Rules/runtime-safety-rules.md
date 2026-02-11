---
name: runtime-safety-rules
description: |
  Unified runtime safety policy for environment isolation, stable error contracts, and structured logging.
  Consolidates environment_rules, error_handling_rules, and logging_standards.
activation: always_on
---

<rule name="runtime-safety-rules" version="1.0.0">
  <metadata>
    <category>safety</category>
    <severity>error</severity>
  </metadata>

  <goal>Ensure runtime behavior is safe, traceable, and production-appropriate.</goal>

  <dependency_environment_policy>
    <must>Use isolated project environments for Python workflows (e.g., `.venv`).</must>
    <must_not>Install project dependencies globally without explicit user request.</must_not>
    <must>Verify interpreter paths when running Python commands.</must>
    <must>Keep local environment folders out of version control.</must>
  </dependency_environment_policy>

  <error_contract>
    <must>Use stable API error envelope fields: `code`, `message`, `details`, `correlation_id`.</must>
    <must>Include a correlation identifier on error responses for traceability.</must>
    <must>Log detailed internal error context server-side before sanitization.</must>
    <must_not>Expose stack traces or internal implementation details to users.</must_not>
    <must_not>Use inconsistent error response structures across endpoints.</must_not>
  </error_contract>

  <logging_policy>
    <must>Use structured logging in production with timestamp, level, message, correlation_id, and context fields.</must>
    <must>Use appropriate log levels (`DEBUG`, `INFO`, `WARN`, `ERROR`).</must>
    <must_not>Log credentials, tokens, secrets, or sensitive personal data.</must_not>
    <must_not>Use ad hoc console logging in production runtime paths.</must_not>
  </logging_policy>

  <correlation_id_propagation>
    <rule>Create correlation IDs at request boundaries.</rule>
    <rule>Propagate correlation IDs through downstream calls.</rule>
    <rule>Use the same identifier across logs and error responses.</rule>
  </correlation_id_propagation>
</rule>
