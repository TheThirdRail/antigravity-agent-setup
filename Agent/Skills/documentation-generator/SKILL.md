---
name: documentation-generator
description: |
  Generate comprehensive documentation from code analysis including README sections,
  API docs, ADRs, and deployment guides. Distinct from /tutor (teaching) - this
  is systematic documentation generation for maintainability.
---

<skill name="documentation-generator" version="1.0.0">
  <metadata>
    <keywords>documentation, readme, api-docs, adr, jsdoc, docstrings</keywords>
  </metadata>

  <goal>Generate clear, accurate, and maintainable documentation that reduces onboarding time.</goal>

  <distinction>
    <versus skill="tutor-workflow">
      <difference>/tutor TEACHES concepts to the user</difference>
      <difference>documentation-generator PRODUCES documentation files</difference>
    </versus>
  </distinction>

  <when_to_use>
    <trigger>"document this", "create README", "API docs"</trigger>
    <trigger>New project setup requiring documentation</trigger>
    <trigger>Code review feedback about missing docs</trigger>
    <trigger>Preparing for public release</trigger>
    <trigger>Recording architecture decisions</trigger>
  </when_to_use>

  <workflow>
    <step number="1" name="Identify Documentation Type">
      <options>
        <option name="README">Project overview, setup, usage</option>
        <option name="API Reference">Endpoints, parameters, responses</option>
        <option name="ADR">Architecture Decision Record</option>
        <option name="Deployment Guide">Step-by-step deployment</option>
        <option name="Troubleshooting">Common issues and solutions</option>
        <option name="Changelog">Version history</option>
      </options>
    </step>

    <step number="2" name="Identify Audience">
      <audiences>
        <audience name="Developers">Technical, need APIs and code examples</audience>
        <audience name="End Users">Non-technical, need features and UI</audience>
        <audience name="Ops/DevOps">Need deployment and monitoring</audience>
        <audience name="New Team Members">Need onboarding and architecture</audience>
      </audiences>
    </step>

    <step number="3" name="Extract Information">
      <sources>
        <source>Code analysis (functions, classes, modules)</source>
        <source>Package files (package.json, requirements.txt)</source>
        <source>Configuration files</source>
        <source>Existing comments and docstrings</source>
        <source>Test files for usage examples</source>
      </sources>
    </step>

    <step number="4" name="Generate Documentation">
      <instruction>Use appropriate template from templates section</instruction>
      <quality_checks>
        <check>All code examples are tested and work</check>
        <check>No placeholder text remains</check>
        <check>Links are valid</check>
        <check>Version numbers are current</check>
      </quality_checks>
    </step>

    <step number="5" name="Add Diagrams">
      <instruction>Include visual aids where helpful</instruction>
      <formats>
        <format name="Mermaid">Inline diagrams in markdown</format>
        <format name="ASCII">Simple text diagrams</format>
        <format name="PlantUML">Complex sequence/class diagrams</format>
      </formats>
    </step>
  </workflow>

  <templates>
    <template name="README.md">
      <structure>
# Project Name

Brief description of what this project does and why it exists.

## Prerequisites

- Node.js 18+
- PostgreSQL 14+
- (other requirements)

## Installation

```bash
git clone [repo-url]
cd [project-name]
npm install
cp .env.example .env
# Edit .env with your values
```

## Usage

```bash
npm run dev
```

## API Documentation

See [docs/API.md](docs/API.md) for endpoint documentation.

## Testing

```bash
npm test
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT
      </structure>
    </template>

    <template name="ADR">
      <structure>
# ADR-NNN: [Decision Title]

## Status

Proposed | Accepted | Deprecated | Superseded by ADR-XXX

## Context

What is the issue that we're seeing that motivates this decision or change?

## Decision

What is the change that we're proposing and/or doing?

## Consequences

### Positive
- (benefits)

### Negative
- (downsides)

### Neutral
- (trade-offs to be aware of)
      </structure>
    </template>

    <template name="API Endpoint">
      <structure>
## Endpoint Name

`METHOD /path/to/endpoint`

Description of what this endpoint does.

### Request

**Headers**
| Header | Required | Description |
|--------|----------|-------------|
| Authorization | Yes | Bearer token |

**Parameters**
| Param | Type | Required | Description |
|-------|------|----------|-------------|
| id | string | Yes | Resource ID |

**Body**
```json
{
  "field": "value"
}
```

### Response

**Success (200)**
```json
{
  "id": "123",
  "name": "Example"
}
```

**Error (400)**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input"
  }
}
```
      </structure>
    </template>

    <template name="Changelog">
      <structure>
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New feature descriptions

### Changed
- Changes in existing functionality

### Deprecated
- Soon-to-be removed features

### Removed
- Removed features

### Fixed
- Bug fixes

### Security
- Vulnerability fixes

## [1.0.0] - YYYY-MM-DD

### Added
- Initial release
      </structure>
    </template>
  </templates>

  <best_practices>
    <do>Keep documentation close to the code it describes</do>
    <do>Include working code examples</do>
    <do>Use clear, simple language</do>
    <do>Update docs when code changes</do>
    <do>Include "last updated" dates for time-sensitive info</do>
    <dont>Document obvious things</dont>
    <dont>Leave TODO placeholders in published docs</dont>
    <dont>Copy-paste without verifying accuracy</dont>
  </best_practices>

  <related_skills>
    <skill>api-builder</skill>
    <skill>architecture-planner</skill>
  </related_skills>

  <related_workflows>
    <workflow>/tutor</workflow>
    <workflow>/handoff</workflow>
  </related_workflows>
</skill>
