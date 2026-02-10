---
name: error-handling-rules
description: |
  Enforce consistent error handling patterns across all backend code.
  Ensures user-friendly messages, proper logging, and traceability.
activation: always_on
---

<rule name="error-handling-rules" version="1.0.0">
  <metadata>
    <category>standards</category>
    <severity>error</severity>
  </metadata>

  <goal>Ensure all errors are handled consistently with proper structure, logging, and user safety.</goal>

  <error_response_format>
    <standard>
      All API error responses MUST follow this structure:
      ```json
      {
        "error": {
          "code": "ERROR_CODE",
          "message": "User-friendly message",
          "details": { },
          "correlation_id": "uuid"
        }
      }
      ```
    </standard>
    <fields>
      <field name="code">Machine-readable error code (SCREAMING_SNAKE_CASE)</field>
      <field name="message">Human-readable explanation safe to show users</field>
      <field name="details">Optional object with field-level errors or context</field>
      <field name="correlation_id">UUID from request header or generated per-request</field>
    </fields>
  </error_response_format>

  <constraints>
    <must>
      <behavior>Include correlation_id in every error response for traceability</behavior>
      <behavior>Log full error details (including stack trace) server-side BEFORE sanitizing</behavior>
      <behavior>Map internal errors to user-safe messages (do not expose implementation details)</behavior>
      <behavior>Use appropriate HTTP status codes (400 for client errors, 500 for server errors)</behavior>
    </must>
    <must_not>
      <behavior>Expose stack traces in production API responses</behavior>
      <behavior>Return generic "Something went wrong" without a correlation_id</behavior>
      <behavior>Swallow errors silently (always log or propagate)</behavior>
      <behavior>Use inconsistent error formats across endpoints</behavior>
    </must_not>
  </constraints>

  <examples>
    <example type="good" description="Proper error response">
      <code language="json">
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "details": { "field": "email", "value": "not-an-email" },
    "correlation_id": "550e8400-e29b-41d4-a716-446655440000"
  }
}
      </code>
    </example>
    <example type="bad" description="Exposing internal details">
      <code language="json">
{
  "error": "TypeError: Cannot read property 'id' of undefined\n    at Object.<anonymous> (/app/src/user.js:42:15)"
}
      </code>
    </example>
  </examples>

  <error_codes>
    <code name="VALIDATION_ERROR">Input validation failed (400)</code>
    <code name="NOT_FOUND">Resource does not exist (404)</code>
    <code name="UNAUTHORIZED">Authentication required (401)</code>
    <code name="FORBIDDEN">Permission denied (403)</code>
    <code name="CONFLICT">Resource conflict (409)</code>
    <code name="RATE_LIMITED">Too many requests (429)</code>
    <code name="INTERNAL_ERROR">Server error (500)</code>
  </error_codes>
</rule>
