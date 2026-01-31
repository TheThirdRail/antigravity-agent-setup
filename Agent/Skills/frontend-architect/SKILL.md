---
name: frontend-architect
description: |
  Design and build modern frontend applications with component architecture,
  state management, responsive design, and accessibility. Use for UI development,
  component creation, and frontend system design.
---

<skill name="frontend-architect" version="1.0.0">
  <metadata>
    <keywords>frontend, ui, react, vue, svelte, components, css, accessibility, responsive</keywords>
  </metadata>

  <goal>Design scalable, accessible, and performant frontend architecture following modern best practices.</goal>

  <core_principles>
    <principle name="Component Architecture">
      <pattern name="Composition over Inheritance">
        Build UIs from small, reusable components that compose together.
      </pattern>
      <pattern name="Single Responsibility">
        Each component should do one thing well.
      </pattern>
      <pattern name="Props Down, Events Up">
        Data flows down via props; child components emit events to communicate up.
      </pattern>
    </principle>

    <principle name="State Management">
      <level name="Local State">
        Component-scoped state for UI interactions (useState, ref).
        <use_when>State doesn't need to be shared</use_when>
      </level>
      <level name="Shared State">
        Context or state stores for cross-component data.
        <use_when>Multiple components need the same data</use_when>
      </level>
      <level name="Server State">
        React Query, SWR, or similar for async data.
        <use_when>Data comes from APIs</use_when>
      </level>
      <antipattern>Don't put everything in global state</antipattern>
    </principle>

    <principle name="Responsive Design">
      <approach name="Mobile First">
        Design for mobile, then enhance for larger screens.
      </approach>
      <breakpoints>
        <breakpoint name="sm" value="640px">Mobile landscape</breakpoint>
        <breakpoint name="md" value="768px">Tablet</breakpoint>
        <breakpoint name="lg" value="1024px">Desktop</breakpoint>
        <breakpoint name="xl" value="1280px">Large desktop</breakpoint>
      </breakpoints>
      <techniques>
        <technique>Flexible grids (CSS Grid, Flexbox)</technique>
        <technique>Relative units (rem, %, vh/vw)</technique>
        <technique>Responsive images (srcset, picture)</technique>
      </techniques>
    </principle>
  </core_principles>

  <accessibility name="WCAG 2.1 AA Compliance">
    <important>Accessibility is NOT optional. Include in every component.</important>
    
    <checklist>
      <check category="Perceivable">
        <item>All images have descriptive alt text</item>
        <item>Color contrast ratio ≥ 4.5:1 for normal text</item>
        <item>Color is not the only way to convey information</item>
        <item>Text can be resized to 200% without loss</item>
      </check>
      <check category="Operable">
        <item>All interactive elements are keyboard accessible</item>
        <item>Focus indicators are visible</item>
        <item>No keyboard traps</item>
        <item>Skip links for navigation</item>
      </check>
      <check category="Understandable">
        <item>Form inputs have associated labels</item>
        <item>Error messages are clear and helpful</item>
        <item>Language is declared on html element</item>
      </check>
      <check category="Robust">
        <item>Valid HTML markup</item>
        <item>Proper ARIA attributes when needed</item>
        <item>Works with screen readers</item>
      </check>
    </checklist>

    <patterns>
      <pattern name="Skip Navigation Link">
        <code language="html">
          &lt;a href="#main-content" class="skip-link"&gt;Skip to main content&lt;/a&gt;
        </code>
      </pattern>
      <pattern name="Accessible Form">
        <code language="html">
          &lt;label for="email"&gt;Email Address&lt;/label&gt;
          &lt;input id="email" type="email" aria-required="true" aria-describedby="email-help"&gt;
          &lt;span id="email-help"&gt;We'll never share your email&lt;/span&gt;
        </code>
      </pattern>
      <pattern name="Modal Focus Trap">
        Focus must stay inside modal until closed. Close on Escape key.
      </pattern>
    </patterns>
  </accessibility>

  <when_to_use>
    <trigger>Building new UI components</trigger>
    <trigger>Designing frontend architecture</trigger>
    <trigger>Creating responsive layouts</trigger>
    <trigger>Implementing forms and user interactions</trigger>
    <trigger>Setting up design systems</trigger>
  </when_to_use>

  <workflow>
    <step number="1" name="Understand Requirements">
      <question>What user problem are we solving?</question>
      <question>What devices and browsers must we support?</question>
      <question>Are there existing design specs or mockups?</question>
    </step>

    <step number="2" name="Plan Component Structure">
      <instruction>Break UI into component hierarchy</instruction>
      <output>Component tree diagram or list</output>
    </step>

    <step number="3" name="Define Props and State">
      <instruction>For each component, determine:</instruction>
      <question>What props does it receive?</question>
      <question>What local state does it manage?</question>
      <question>What events does it emit?</question>
    </step>

    <step number="4" name="Build Bottom-Up">
      <instruction>Start with smallest, reusable components</instruction>
      <order>
        <item>Atoms (Button, Input, Label)</item>
        <item>Molecules (FormField, Card, MenuItem)</item>
        <item>Organisms (Header, Sidebar, Form)</item>
        <item>Templates (Layout structures)</item>
        <item>Pages (Full views)</item>
      </order>
    </step>

    <step number="5" name="Apply Styling">
      <instruction>Use consistent styling approach</instruction>
      <approaches>
        <approach name="CSS Modules">Scoped styles per component</approach>
        <approach name="Styled Components">CSS-in-JS for dynamic styles</approach>
        <approach name="Tailwind">Utility-first for rapid development</approach>
        <approach name="CSS Variables">Design tokens for theming</approach>
      </approaches>
    </step>

    <step number="6" name="Add Interactivity">
      <instruction>Implement user interactions</instruction>
      <considerations>
        <item>Loading states</item>
        <item>Error states</item>
        <item>Empty states</item>
        <item>Hover/focus states</item>
        <item>Transitions and animations</item>
      </considerations>
    </step>

    <step number="7" name="Verify Accessibility">
      <instruction>Test with keyboard and screen reader</instruction>
      <tools>
        <tool>axe DevTools (browser extension)</tool>
        <tool>Keyboard navigation testing</tool>
        <tool>Color contrast checker</tool>
      </tools>
    </step>
  </workflow>

  <patterns>
    <pattern name="Container/Presentational">
      <description>Separate data-fetching logic from rendering</description>
      <container>Handles data, state, and business logic</container>
      <presentational>Pure rendering based on props</presentational>
    </pattern>

    <pattern name="Compound Components">
      <description>Components that work together implicitly</description>
      <example>
        &lt;Tabs&gt;
          &lt;Tab&gt;First&lt;/Tab&gt;
          &lt;Tab&gt;Second&lt;/Tab&gt;
          &lt;TabPanel&gt;Content 1&lt;/TabPanel&gt;
          &lt;TabPanel&gt;Content 2&lt;/TabPanel&gt;
        &lt;/Tabs&gt;
      </example>
    </pattern>

    <pattern name="Render Props / Slots">
      <description>Let parent control what child renders</description>
      <use_case>Highly customizable components</use_case>
    </pattern>

    <pattern name="Custom Hooks">
      <description>Extract reusable stateful logic</description>
      <examples>
        <example>useForm() - form state and validation</example>
        <example>useDebounce() - debounced values</example>
        <example>useFetch() - data fetching</example>
      </examples>
    </pattern>
  </patterns>

  <best_practices>
    <do>Use semantic HTML elements</do>
    <do>Keep components small and focused</do>
    <do>Colocate styles with components</do>
    <do>Test components in isolation</do>
    <do>Support keyboard navigation</do>
    <do>Provide loading and error states</do>
    <dont>Nest too deeply (max 3-4 levels)</dont>
    <dont>Hardcode colors or sizes</dont>
    <dont>Ignore mobile users</dont>
    <dont>Forget focus management in modals</dont>
  </best_practices>

  <related_skills>
    <skill>api-builder</skill>
    <skill>test-generator</skill>
    <skill>code-reviewer</skill>
  </related_skills>
</skill>
