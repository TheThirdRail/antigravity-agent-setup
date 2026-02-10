---
name: environment-rules
description: |
  Python virtual environment enforcement and isolation protocols.
  Prevents global package pollution and ensures reproducible environments.
activation: always_on
---

<rule name="environment-rules" version="1.0.0">
  <metadata>
    <category>standards</category>
    <severity>error</severity>
  </metadata>

  <goal>Ensure all Python code runs in isolated virtual environments.</goal>

  <trigger>Writing or executing Python code, or installing packages.</trigger>

  <constraints>
    <STOP>DO NOT install packages globally (no `pip install` without venv).</STOP>
    <STOP>DO NOT run python scripts without a virtual environment active.</STOP>
  </constraints>

  <protocol>
    <step number="1">Check for existing venv (e.g., `.venv` or `venv` folders).</step>
    <step number="2">If none exists, create one: `python -m venv .venv`.</step>
    <step number="3">Activate BEFORE every new terminal session:
      - Windows: `.venv\Scripts\activate`
      - Unix: `source .venv/bin/activate`
    </step>
    <step number="4">Install dependencies ONLY into the active venv.</step>
    <step number="5">Add `.venv/` to `.gitignore`.</step>
  </protocol>

  <verification>
    <check>Run `which python` (Unix) or `where python` (Windows) to confirm venv path.</check>
    <check>Prompt should show `(.venv)` prefix when activated.</check>
  </verification>
</rule>
