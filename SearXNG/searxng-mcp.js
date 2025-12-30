#!/usr/bin/env node

/**
 * SearXNG MCP Server
 * 
 * An MCP server that provides web search capabilities through a self-hosted SearXNG instance.
 * 
 * Environment Variables:
 *   SEARXNG_HOST - The SearXNG instance URL (e.g., http://localhost)
 *   SEARXNG_PORT - The SearXNG instance port (e.g., 8080)
 */

import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
    CallToolRequestSchema,
    ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';

// Configuration from environment variables
const SEARXNG_HOST = process.env.SEARXNG_HOST || 'http://localhost';
const SEARXNG_PORT = process.env.SEARXNG_PORT || '8080';
const SEARXNG_URL = `${SEARXNG_HOST}:${SEARXNG_PORT}`;

// Create the MCP server
const server = new Server(
    {
        name: 'searxng',
        version: '1.0.0',
    },
    {
        capabilities: {
            tools: {},
        },
    }
);

// Define available tools
server.setRequestHandler(ListToolsRequestSchema, async () => {
    return {
        tools: [
            {
                name: 'search',
                description: 'Search the web using SearXNG metasearch engine. Returns results from multiple search engines.',
                inputSchema: {
                    type: 'object',
                    properties: {
                        query: {
                            type: 'string',
                            description: 'The search query',
                        },
                        categories: {
                            type: 'string',
                            description: 'Comma-separated categories to search (e.g., "general", "images", "videos", "news", "music", "files", "it", "science", "social media")',
                            default: 'general',
                        },
                        language: {
                            type: 'string',
                            description: 'Language code for results (e.g., "en", "de", "fr", "auto")',
                            default: 'auto',
                        },
                        time_range: {
                            type: 'string',
                            description: 'Time range filter: "day", "week", "month", "year", or empty for all time',
                            enum: ['', 'day', 'week', 'month', 'year'],
                        },
                        safesearch: {
                            type: 'number',
                            description: 'Safe search level: 0 (off), 1 (moderate), 2 (strict)',
                            enum: [0, 1, 2],
                            default: 0,
                        },
                        pageno: {
                            type: 'number',
                            description: 'Page number of results (starts at 1)',
                            default: 1,
                        },
                        max_results: {
                            type: 'number',
                            description: 'Maximum number of results to return',
                            default: 10,
                        },
                    },
                    required: ['query'],
                },
            },
            {
                name: 'search_images',
                description: 'Search for images using SearXNG',
                inputSchema: {
                    type: 'object',
                    properties: {
                        query: {
                            type: 'string',
                            description: 'The image search query',
                        },
                        max_results: {
                            type: 'number',
                            description: 'Maximum number of results to return',
                            default: 10,
                        },
                    },
                    required: ['query'],
                },
            },
            {
                name: 'search_news',
                description: 'Search for news articles using SearXNG',
                inputSchema: {
                    type: 'object',
                    properties: {
                        query: {
                            type: 'string',
                            description: 'The news search query',
                        },
                        time_range: {
                            type: 'string',
                            description: 'Time range: "day", "week", "month", "year"',
                            enum: ['day', 'week', 'month', 'year'],
                            default: 'week',
                        },
                        max_results: {
                            type: 'number',
                            description: 'Maximum number of results to return',
                            default: 10,
                        },
                    },
                    required: ['query'],
                },
            },
            // === CODING-FOCUSED TOOLS ===
            {
                name: 'search_code',
                description: 'Search for programming and IT-related content. Uses the IT category which includes coding tutorials, documentation, and technical articles.',
                inputSchema: {
                    type: 'object',
                    properties: {
                        query: {
                            type: 'string',
                            description: 'The programming/code search query (e.g., "python async await", "react hooks tutorial")',
                        },
                        language: {
                            type: 'string',
                            description: 'Programming language to focus on (added to query)',
                        },
                        max_results: {
                            type: 'number',
                            description: 'Maximum number of results to return',
                            default: 10,
                        },
                    },
                    required: ['query'],
                },
            },
            {
                name: 'search_stackoverflow',
                description: 'Search Stack Overflow and programming Q&A sites for coding solutions and answers.',
                inputSchema: {
                    type: 'object',
                    properties: {
                        query: {
                            type: 'string',
                            description: 'The coding question or error message to search for',
                        },
                        max_results: {
                            type: 'number',
                            description: 'Maximum number of results to return',
                            default: 10,
                        },
                    },
                    required: ['query'],
                },
            },
            {
                name: 'search_docs',
                description: 'Search for official documentation and API references. Targets documentation sites like MDN, ReadTheDocs, official docs.',
                inputSchema: {
                    type: 'object',
                    properties: {
                        query: {
                            type: 'string',
                            description: 'The documentation search query (e.g., "useState hook", "pandas dataframe")',
                        },
                        framework: {
                            type: 'string',
                            description: 'Framework or library name to focus on (e.g., "react", "django", "pytorch")',
                        },
                        max_results: {
                            type: 'number',
                            description: 'Maximum number of results to return',
                            default: 10,
                        },
                    },
                    required: ['query'],
                },
            },
            {
                name: 'search_packages',
                description: 'Search for packages and libraries on npm, PyPI, crates.io, and other package registries.',
                inputSchema: {
                    type: 'object',
                    properties: {
                        query: {
                            type: 'string',
                            description: 'The package name or functionality to search for',
                        },
                        registry: {
                            type: 'string',
                            description: 'Package registry to focus on: "npm", "pypi", "crates", "rubygems", or "all"',
                            enum: ['npm', 'pypi', 'crates', 'rubygems', 'all'],
                            default: 'all',
                        },
                        max_results: {
                            type: 'number',
                            description: 'Maximum number of results to return',
                            default: 10,
                        },
                    },
                    required: ['query'],
                },
            },
            {
                name: 'search_github',
                description: 'Search for GitHub repositories, code, and projects.',
                inputSchema: {
                    type: 'object',
                    properties: {
                        query: {
                            type: 'string',
                            description: 'The search query for GitHub repos/code',
                        },
                        search_type: {
                            type: 'string',
                            description: 'Type of GitHub search: "repos" for repositories, "code" for code snippets',
                            enum: ['repos', 'code'],
                            default: 'repos',
                        },
                        max_results: {
                            type: 'number',
                            description: 'Maximum number of results to return',
                            default: 10,
                        },
                    },
                    required: ['query'],
                },
            },
        ],
    };
});

// Handle tool calls
server.setRequestHandler(CallToolRequestSchema, async (request) => {
    const { name, arguments: args } = request.params;

    try {
        switch (name) {
            case 'search': {
                const results = await performSearch({
                    q: args.query,
                    categories: args.categories || 'general',
                    language: args.language || 'auto',
                    time_range: args.time_range || '',
                    safesearch: args.safesearch ?? 0,
                    pageno: args.pageno || 1,
                });

                const maxResults = args.max_results || 10;
                const limitedResults = results.slice(0, maxResults);

                return {
                    content: [
                        {
                            type: 'text',
                            text: formatSearchResults(limitedResults, args.query),
                        },
                    ],
                };
            }

            case 'search_images': {
                const results = await performSearch({
                    q: args.query,
                    categories: 'images',
                });

                const maxResults = args.max_results || 10;
                const limitedResults = results.slice(0, maxResults);

                return {
                    content: [
                        {
                            type: 'text',
                            text: formatImageResults(limitedResults, args.query),
                        },
                    ],
                };
            }

            case 'search_news': {
                const results = await performSearch({
                    q: args.query,
                    categories: 'news',
                    time_range: args.time_range || 'week',
                });

                const maxResults = args.max_results || 10;
                const limitedResults = results.slice(0, maxResults);

                return {
                    content: [
                        {
                            type: 'text',
                            text: formatNewsResults(limitedResults, args.query),
                        },
                    ],
                };
            }

            // === CODING-FOCUSED TOOL HANDLERS ===
            case 'search_code': {
                let searchQuery = args.query;
                if (args.language) {
                    searchQuery = `${args.language} ${searchQuery}`;
                }
                const results = await performSearch({
                    q: searchQuery,
                    categories: 'it',
                });

                const maxResults = args.max_results || 10;
                const limitedResults = results.slice(0, maxResults);

                return {
                    content: [
                        {
                            type: 'text',
                            text: formatCodeResults(limitedResults, args.query),
                        },
                    ],
                };
            }

            case 'search_stackoverflow': {
                const results = await performSearch({
                    q: `site:stackoverflow.com OR site:stackexchange.com ${args.query}`,
                    categories: 'general',
                });

                const maxResults = args.max_results || 10;
                const limitedResults = results.slice(0, maxResults);

                return {
                    content: [
                        {
                            type: 'text',
                            text: formatStackOverflowResults(limitedResults, args.query),
                        },
                    ],
                };
            }

            case 'search_docs': {
                let searchQuery = args.query;
                if (args.framework) {
                    searchQuery = `${args.framework} ${searchQuery} documentation`;
                } else {
                    searchQuery = `${searchQuery} documentation`;
                }
                const results = await performSearch({
                    q: searchQuery,
                    categories: 'it',
                });

                const maxResults = args.max_results || 10;
                const limitedResults = results.slice(0, maxResults);

                return {
                    content: [
                        {
                            type: 'text',
                            text: formatDocsResults(limitedResults, args.query),
                        },
                    ],
                };
            }

            case 'search_packages': {
                let siteFilter = '';
                switch (args.registry) {
                    case 'npm':
                        siteFilter = 'site:npmjs.com';
                        break;
                    case 'pypi':
                        siteFilter = 'site:pypi.org';
                        break;
                    case 'crates':
                        siteFilter = 'site:crates.io';
                        break;
                    case 'rubygems':
                        siteFilter = 'site:rubygems.org';
                        break;
                    default:
                        siteFilter = 'site:npmjs.com OR site:pypi.org OR site:crates.io OR site:rubygems.org';
                }
                const results = await performSearch({
                    q: `${siteFilter} ${args.query}`,
                    categories: 'general',
                });

                const maxResults = args.max_results || 10;
                const limitedResults = results.slice(0, maxResults);

                return {
                    content: [
                        {
                            type: 'text',
                            text: formatPackageResults(limitedResults, args.query),
                        },
                    ],
                };
            }

            case 'search_github': {
                const siteFilter = args.search_type === 'code'
                    ? 'site:github.com inurl:blob'
                    : 'site:github.com';
                const results = await performSearch({
                    q: `${siteFilter} ${args.query}`,
                    categories: 'general',
                });

                const maxResults = args.max_results || 10;
                const limitedResults = results.slice(0, maxResults);

                return {
                    content: [
                        {
                            type: 'text',
                            text: formatGitHubResults(limitedResults, args.query, args.search_type || 'repos'),
                        },
                    ],
                };
            }

            default:
                throw new Error(`Unknown tool: ${name}`);
        }
    } catch (error) {
        return {
            content: [
                {
                    type: 'text',
                    text: `Error executing search: ${error.message}`,
                },
            ],
            isError: true,
        };
    }
});

/**
 * Perform a search query against the SearXNG instance
 */
async function performSearch(params) {
    const searchParams = new URLSearchParams({
        q: params.q,
        format: 'json',
        ...params,
    });

    const url = `${SEARXNG_URL}/search?${searchParams.toString()}`;

    const response = await fetch(url, {
        headers: {
            'Accept': 'application/json',
        },
    });

    if (!response.ok) {
        throw new Error(`SearXNG returned status ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data.results || [];
}

/**
 * Format general search results for display
 */
function formatSearchResults(results, query) {
    if (results.length === 0) {
        return `No results found for: "${query}"`;
    }

    let output = `## Search Results for: "${query}"\n\n`;

    results.forEach((result, index) => {
        output += `### ${index + 1}. ${result.title || 'No title'}\n`;
        output += `**URL:** ${result.url}\n`;
        if (result.content) {
            output += `${result.content}\n`;
        }
        if (result.engine) {
            output += `*Source: ${result.engine}*\n`;
        }
        output += '\n';
    });

    return output;
}

/**
 * Format image search results
 */
function formatImageResults(results, query) {
    if (results.length === 0) {
        return `No image results found for: "${query}"`;
    }

    let output = `## Image Results for: "${query}"\n\n`;

    results.forEach((result, index) => {
        output += `### ${index + 1}. ${result.title || 'No title'}\n`;
        output += `**Image URL:** ${result.img_src || result.url}\n`;
        output += `**Page URL:** ${result.url}\n`;
        if (result.source) {
            output += `*Source: ${result.source}*\n`;
        }
        output += '\n';
    });

    return output;
}

/**
 * Format news search results
 */
function formatNewsResults(results, query) {
    if (results.length === 0) {
        return `No news results found for: "${query}"`;
    }

    let output = `## News Results for: "${query}"\n\n`;

    results.forEach((result, index) => {
        output += `### ${index + 1}. ${result.title || 'No title'}\n`;
        output += `**URL:** ${result.url}\n`;
        if (result.publishedDate) {
            output += `**Published:** ${result.publishedDate}\n`;
        }
        if (result.content) {
            output += `${result.content}\n`;
        }
        if (result.engine) {
            output += `*Source: ${result.engine}*\n`;
        }
        output += '\n';
    });

    return output;
}

// === CODING-FOCUSED FORMATTERS ===

/**
 * Format code/IT search results
 */
function formatCodeResults(results, query) {
    if (results.length === 0) {
        return `No code/IT results found for: "${query}"`;
    }

    let output = `## Code & IT Results for: "${query}"\n\n`;

    results.forEach((result, index) => {
        output += `### ${index + 1}. ${result.title || 'No title'}\n`;
        output += `**URL:** ${result.url}\n`;
        if (result.content) {
            output += `${result.content}\n`;
        }
        if (result.engine) {
            output += `*Source: ${result.engine}*\n`;
        }
        output += '\n';
    });

    return output;
}

/**
 * Format Stack Overflow results
 */
function formatStackOverflowResults(results, query) {
    if (results.length === 0) {
        return `No Stack Overflow results found for: "${query}"`;
    }

    let output = `## Stack Overflow Results for: "${query}"\n\n`;

    results.forEach((result, index) => {
        output += `### ${index + 1}. ${result.title || 'No title'}\n`;
        output += `**URL:** ${result.url}\n`;
        if (result.content) {
            output += `${result.content}\n`;
        }
        output += '\n';
    });

    return output;
}

/**
 * Format documentation results
 */
function formatDocsResults(results, query) {
    if (results.length === 0) {
        return `No documentation found for: "${query}"`;
    }

    let output = `## Documentation Results for: "${query}"\n\n`;

    results.forEach((result, index) => {
        output += `### ${index + 1}. ${result.title || 'No title'}\n`;
        output += `**URL:** ${result.url}\n`;
        if (result.content) {
            output += `${result.content}\n`;
        }
        if (result.engine) {
            output += `*Source: ${result.engine}*\n`;
        }
        output += '\n';
    });

    return output;
}

/**
 * Format package registry results
 */
function formatPackageResults(results, query) {
    if (results.length === 0) {
        return `No packages found for: "${query}"`;
    }

    let output = `## Package Results for: "${query}"\n\n`;

    results.forEach((result, index) => {
        // Try to detect registry from URL
        let registry = 'Unknown';
        if (result.url.includes('npmjs.com')) registry = 'npm';
        else if (result.url.includes('pypi.org')) registry = 'PyPI';
        else if (result.url.includes('crates.io')) registry = 'crates.io';
        else if (result.url.includes('rubygems.org')) registry = 'RubyGems';

        output += `### ${index + 1}. ${result.title || 'No title'}\n`;
        output += `**Registry:** ${registry}\n`;
        output += `**URL:** ${result.url}\n`;
        if (result.content) {
            output += `${result.content}\n`;
        }
        output += '\n';
    });

    return output;
}

/**
 * Format GitHub results
 */
function formatGitHubResults(results, query, searchType) {
    if (results.length === 0) {
        return `No GitHub ${searchType} found for: "${query}"`;
    }

    let output = `## GitHub ${searchType === 'repos' ? 'Repository' : 'Code'} Results for: "${query}"\n\n`;

    results.forEach((result, index) => {
        output += `### ${index + 1}. ${result.title || 'No title'}\n`;
        output += `**URL:** ${result.url}\n`;
        if (result.content) {
            output += `${result.content}\n`;
        }
        output += '\n';
    });

    return output;
}

// Start the server
async function main() {
    const transport = new StdioServerTransport();
    await server.connect(transport);
    console.error('SearXNG MCP server running on stdio');
    console.error(`Configured to connect to: ${SEARXNG_URL}`);
}

main().catch((error) => {
    console.error('Fatal error:', error);
    process.exit(1);
});
