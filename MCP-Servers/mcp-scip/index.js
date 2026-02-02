#!/usr/bin/env node

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
    CallToolRequestSchema,
    ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { exec } from "child_process";
import { promisify } from "util";
import fs from "fs";
import path from "path";

const execAsync = promisify(exec);

const server = new Server(
    {
        name: "mcp-scip",
        version: "1.0.0",
    },
    {
        capabilities: {
            tools: {},
        },
    }
);

server.setRequestHandler(ListToolsRequestSchema, async () => {
    return {
        tools: [
            {
                name: "index_typescript",
                description: "Generate SCIP index for a TypeScript/JavaScript project",
                inputSchema: {
                    type: "object",
                    properties: {
                        projectPath: {
                            type: "string",
                            description: "Absolute path to the project root (containing package.json)",
                        },
                    },
                    required: ["projectPath"],
                },
            },
            {
                name: "index_python",
                description: "Generate SCIP index for a Python project",
                inputSchema: {
                    type: "object",
                    properties: {
                        projectPath: {
                            type: "string",
                            description: "Absolute path to the project root",
                        },
                    },
                    required: ["projectPath"],
                },
            },
        ],
    };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
    const { name, arguments: args } = request.params;

    if (name === "index_typescript") {
        const projectPath = args.projectPath;
        try {
            // Run scip-typescript
            // Note: Assumes scip-typescript is installed globally or in the container
            const { stdout, stderr } = await execAsync(`scip-typescript index --cwd "${projectPath}" --output "${path.join(projectPath, 'index.scip')}"`);
            return {
                content: [
                    {
                        type: "text",
                        text: `Successfully created index.scip at ${projectPath}\nOutput: ${stdout}\nErrors: ${stderr}`
                    }
                ]
            };
        } catch (error) {
            return {
                content: [
                    {
                        type: "text",
                        text: `Error indexing TypeScript: ${error.message}`
                    }
                ],
                isError: true
            };
        }
    } else if (name === "index_python") {
        const projectPath = args.projectPath;
        try {
            // Run scip-python
            const { stdout, stderr } = await execAsync(`scip-python index --project-name my-project --output "${path.join(projectPath, 'index.scip')}" "${projectPath}"`);
            return {
                content: [
                    {
                        type: "text",
                        text: `Successfully created index.scip at ${projectPath}\nOutput: ${stdout}\nErrors: ${stderr}`
                    }
                ]
            };
        } catch (error) {
            return {
                content: [
                    {
                        type: "text",
                        text: `Error indexing Python: ${error.message}`
                    }
                ],
                isError: true
            }
        }
    }

    throw new Error(`Unknown tool: ${name}`);
});

const transport = new StdioServerTransport();
await server.connect(transport);
