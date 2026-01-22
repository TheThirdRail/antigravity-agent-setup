---
name: docker-ops
description: |
  Direct Docker container management operations for MCP servers. Provides patterns
  for starting, stopping, inspecting, and debugging Docker containers that host
  MCP servers. Essential for troubleshooting and maintaining the Docker MCP stack.
---

<skill name="docker-ops" version="1.0.0">
  <metadata>
    <keywords>docker, containers, debugging, logs, health-checks</keywords>
  </metadata>

  <goal>Provide systematic troubleshooting and operational management for Docker containers hosting MCP servers.</goal>

  <core_principles>
    <principle name="Logs Before Restart">
      <rule>Always check logs first before restarting containers</rule>
      <rule>Restarting masks the root cause of issues</rule>
      <rule>Export logs if needed for later analysis</rule>
    </principle>

    <principle name="Resource Awareness">
      <rule>Set memory and CPU limits in docker-compose</rule>
      <rule>Monitor resource usage with docker stats</rule>
    </principle>

    <principle name="Health-First Operations">
      <rule>Use health checks for all MCP servers</rule>
      <rule>Verify health after any operational changes</rule>
    </principle>
  </core_principles>

  <quick_reference>
    <command purpose="List MCP containers">docker ps --filter "name=mcp"</command>
    <command purpose="View container logs">docker logs &lt;container&gt; --tail 100</command>
    <command purpose="Restart container">docker restart &lt;container&gt;</command>
    <command purpose="Inspect container">docker inspect &lt;container&gt;</command>
    <command purpose="Shell into container">docker exec -it &lt;container&gt; /bin/sh</command>
    <command purpose="View resource usage">docker stats --no-stream</command>
  </quick_reference>

  <troubleshooting_workflows>
    <workflow name="MCP Server Not Responding">
      <step>Check container status: docker ps -a --filter "name=mcp-&lt;server&gt;"</step>
      <step>If stopped, check exit reason: docker logs &lt;container&gt; --tail 50</step>
      <step>If running but unresponsive, check health</step>
      <step>Restart if needed: docker restart &lt;container&gt;</step>
      <step>Verify recovery</step>
    </workflow>

    <workflow name="High Memory/CPU Usage">
      <step>Identify hogs: docker stats --no-stream</step>
      <step>Check for runaway processes: docker exec &lt;container&gt; ps aux</step>
      <step>Restart if necessary</step>
      <step>Set limits: docker update --memory="512m" &lt;container&gt;</step>
    </workflow>
  </troubleshooting_workflows>

  <lifecycle_commands>
    <category name="Starting">
      <command purpose="Start all">docker-compose -f docker-mcp.yml up -d</command>
      <command purpose="Start specific">docker-compose up -d &lt;service&gt;</command>
    </category>

    <category name="Stopping">
      <command purpose="Stop and remove">docker-compose down</command>
      <command purpose="Stop preserve">docker-compose stop</command>
    </category>

    <category name="Updating">
      <command purpose="Pull latest">docker-compose pull</command>
      <command purpose="Recreate">docker-compose up -d --force-recreate</command>
    </category>
  </lifecycle_commands>

  <log_analysis>
    <pattern purpose="View recent errors">docker logs &lt;container&gt; 2&gt;&amp;1 | grep -i "error" | tail -20</pattern>
    <pattern purpose="Watch for events">docker logs -f &lt;container&gt; 2&gt;&amp;1 | grep "tool_call"</pattern>
    <pattern purpose="Export logs">docker logs &lt;container&gt; &gt; mcp-server.log 2&gt;&amp;1</pattern>
  </log_analysis>

  <best_practices>
    <do>Always check logs before restarting</do>
    <do>Set resource limits in docker-compose</do>
    <do>Use health checks for all MCP servers</do>
    <do>Keep containers stateless (use volumes for data)</do>
    <do>Export logs before destroying failed containers</do>
    <dont>Force kill without checking logs</dont>
    <dont>Run containers without resource limits</dont>
    <dont>Store data inside containers</dont>
    <dont>Ignore health check failures</dont>
    <dont>Use docker run for stack containers (use compose)</dont>
  </best_practices>

  <related_skills>
    <skill>mcp-manager</skill>
    <skill>tool-creator</skill>
  </related_skills>
</skill>
