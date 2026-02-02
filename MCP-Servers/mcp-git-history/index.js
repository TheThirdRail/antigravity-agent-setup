#!/usr/bin/env node

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
    CallToolRequestSchema,
    ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { exec } from "child_process";
import { promisify } from "util";
import path from "path";

const execAsync = promisify(exec);

const server = new Server(
    {
        name: "mcp-git-history",
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
                name: "search_commits",
                description: "Search git commit messages and content for specific terms",
                inputSchema: {
                    type: "object",
                    properties: {
                        repoPath: {
                            type: "string",
                            description: "Absolute path to the git repository",
                        },
                        query: {
                            type: "string",
                            description: "Term to search for (uses git log --grep or -S)",
                        },
                        mode: {
                            type: "string",
                            description: "'message' (search commit msg) or 'diff' (search changed content)",
                            enum: ["message", "diff"],
                            default: "message"
                        },
                        limit: {
                            type: "number",
                            description: "Max number of commits to return",
                            default: 10
                        }
                    },
                    required: ["repoPath", "query"],
                },
            },
            {
                name: "get_file_history",
                description: "Get evolution of a specific file",
                inputSchema: {
                    type: "object",
                    properties: {
                        repoPath: { type: "string" },
                        filePath: { type: "string", description: "Relative path to file" },
                        limit: { type: "number", default: 5 }
                    },
                    required: ["repoPath", "filePath"]
                }
            }
        ],
    };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
    const { name, arguments: args } = request.params;
    const repoPath = args.repoPath;
    const limit = args.limit || 10;

    try {
        if (name === "search_commits") {
            const mode = args.mode || "message";
            const query = args.query;
            let cmd = "";

            if (mode === "message") {
                cmd = `git log --grep="${query}" -n ${limit} --pretty=format:"%h|%ad|%s" --date=iso`;
            } else {
                // Search in diffs (pickaxe search)
                cmd = `git log -S "${query}" -n ${limit} --pretty=format:"%h|%ad|%s" --date=iso`;
            }

            const { stdout } = await execAsync(cmd, { cwd: repoPath });
            return {
                content: [{ type: "text", text: stdout || "No matches found." }]
            };

        } else if (name === "get_file_history") {
            const filePath = args.filePath;
            const cmd = `git log -n ${limit} --pretty=format:"%h|%ad|%s" --date=iso -- "${filePath}"`;
            const { stdout } = await execAsync(cmd, { cwd: repoPath });
            return {
                content: [{ type: "text", text: stdout || "No history found for file." }]
            };
        }
    } catch (error) {
        return {
            content: [{ type: "text", text: `Git Error: ${error.message}` }],
            isError: true
        };
    }

    throw new Error(`Unknown tool: ${name}`);
});

const transport = new StdioServerTransport();
await server.connect(transport);
