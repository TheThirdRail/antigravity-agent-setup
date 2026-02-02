---
name: tool-selection-rules
description: Protocol for selecting the optimal search, scraping, or lookup tool based on task type.
activation: always_on
---

<rule name="tool-selection-rules" version="1.0.0">
  <metadata>
    <category>standards</category>
    <severity>info</severity>
  </metadata>

  <goal>Maximize efficiency and accuracy by selecting the specialized tool for the specific task type.</goal>

  <decision_matrix>

    <!-- TIER 1: QUICK FACTS & CHECKS -->
    <use_case type="sanity_check">
      <trigger>User asks for simple fact, weather, date, or quick confirmation</trigger>
      <preferred_tool>search_web</preferred_tool>
      <fallback>searxng</fallback>
      <reasoning>Zero cost, lowest latency, sufficient for simple facts.</reasoning>
    </use_case>

    <!-- TIER 2: ANSWERING QUESTIONS -->
    <use_case type="question_answering">
      <trigger>User asks a "How to", "What is", or "Fix this error" question</trigger>
      <preferred_tool>tavily</preferred_tool>
      <override_condition>If query is extremely niche/technical and Tavily fails, try `exa`</override_condition>
      <reasoning>Tavily returns synthesized answers + citations, saving context window.</reasoning>
    </use_case>

    <!-- TIER 3: DOCUMENTATION & LEARNING -->
    <use_case type="documentation_ingestion">
      <trigger>User says "Read this URL", "Learn these docs", "Scrape this page"</trigger>
      <preferred_tool>fetch (for single page)</preferred_tool>
      <escalation>If content is dynamic (JS) or multiple pages: use `firecrawl`</escalation>
      <reasoning>Fetch is free/fast. Firecrawl is robust for full sites/JS.</reasoning>
    </use_case>

    <!-- TIER 4: EXPLORATION -->
    <use_case type="broad_discovery">
      <trigger>User asks "Find similar projects", "Recommend alternatives", "Find papers"</trigger>
      <preferred_tool>exa</preferred_tool>
      <fallback>searxng</fallback>
      <reasoning>Exa searches by semantic meaning, not just keywords.</reasoning>
    </use_case>

    <!-- TIER 5: HARD TARGETS -->
    <use_case type="complex_scraping">
      <trigger>Scraping social media, maps, auth-walled sites, or complex UIs</trigger>
      <preferred_tool>apify</preferred_tool>
      <fallback>browser_subagent (nuclear option)</fallback>
      <reasoning>Apify actors handle CAPTCHAs and complex flows. Browser subagent is slow/expensive.</reasoning>
    </use_case>

  </decision_matrix>

  <protocol>
    <step>Identify the *primary intent* (Fact, Answer, Read, Explore, Scrape).</step>
    <step>Select the <preferred_tool> from the matrix.</step>
    <step>IF the preferred tool fails OR the user specificially requests deep research:
       -> Log the reason for deviation.
       -> Switch to the <fallback> or <escalation> tool.
    </step>
    <step>IF uncertain: Default to `tavily` for general queries.</step>
  </protocol>

</rule>
