---
name: logging-standards
description: |
  Enforce structured logging practices for observability and debugging.
  Ensures consistent log format, correlation IDs, and appropriate log levels.
activation: always_on
---

<rule name="logging-standards" version="1.0.0">
  <metadata>
    <category>observability</category>
    <severity>warning</severity>
  </metadata>

  <goal>Ensure consistent, structured logging for effective debugging and monitoring.</goal>

  <log_format>
    <standard>Use JSON-structured logs in production environments.</standard>
    <fields>
      <field name="timestamp">ISO 8601 format (e.g., 2026-02-03T08:52:04Z)</field>
      <field name="level">DEBUG, INFO, WARN, ERROR</field>
      <field name="message">Human-readable description</field>
      <field name="correlation_id">UUID linking related requests</field>
      <field name="context">Additional structured data (user_id, request_path, etc.)</field>
    </fields>
    <example>
      ```json
      {
        "timestamp": "2026-02-03T08:52:04Z",
        "level": "ERROR",
        "message": "Failed to process payment",
        "correlation_id": "550e8400-e29b-41d4-a716-446655440000",
        "context": { "user_id": 12345, "amount": 99.99 }
      }
      ```
    </example>
  </log_format>

  <log_levels>
    <level name="DEBUG">Verbose details for development. Never in production.</level>
    <level name="INFO">Normal operations (startup, shutdown, request completed).</level>
    <level name="WARN">Unexpected but recoverable situations.</level>
    <level name="ERROR">Failures requiring attention.</level>
  </log_levels>

  <constraints>
    <must>
      <behavior>Include correlation_id in every log entry for request tracing.</behavior>
      <behavior>Use structured fields, not string interpolation for data.</behavior>
      <behavior>Log at the appropriate level (don't use ERROR for warnings).</behavior>
    </must>
    <must_not>
      <behavior>Log passwords, tokens, API keys, or PII.</behavior>
      <behavior>Use console.log/print in production code (use proper logger).</behavior>
      <behavior>Log at DEBUG level in production.</behavior>
    </must_not>
  </constraints>

  <correlation_id_pattern>
    <instruction>Generate a UUID at the entry point of each request.</instruction>
    <instruction>Pass correlation_id through all downstream service calls.</instruction>
    <instruction>Include in error responses (see error_handling_rules.md).</instruction>
  </correlation_id_pattern>
</rule>
