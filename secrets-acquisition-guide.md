# Secrets Acquisition Guide

A comprehensive guide for obtaining API keys and credentials required by the Antigravity Agent stack.

## 1. Core Model Providers

### Google Gemini (Primary Model)

* **Service**: Google AI Studio
* **Sign-up**: [https://aistudio.google.com/](https://aistudio.google.com/)
* **Key Type**: API Key
* **Env Variable**: `GEMINI_API_KEY`
* **Cost**: Free tier available (Rate limits apply). Paid tier for higher limits.

### OpenAI (Optional/Fallback)

* **Service**: OpenAI Platform
* **Sign-up**: [https://platform.openai.com/](https://platform.openai.com/)
* **Key Type**: API Key
* **Env Variable**: `OPENAI_API_KEY`
* **Cost**: Pay-as-you-go.

### Anthropic (Optional/Fallback)

* **Service**: Anthropic Console
* **Sign-up**: [https://console.anthropic.com/](https://console.anthropic.com/)
* **Key Type**: API Key
* **Env Variable**: `ANTHROPIC_API_KEY`
* **Cost**: Prepaid credits required.

## 2. Search & Information Tools

### Brave Search (Web Search)

* **Service**: Brave Search API
* **Sign-up**: [https://api.search.brave.com/app/dashboard](https://api.search.brave.com/app/dashboard)
* **Key Type**: API Key
* **Env Variable**: `BRAVE_API_KEY`
* **Cost**: Free tier (2k requests/month). Paid tiers available.

### Tavily (AI Search Optimization)

* **Service**: Tavily
* **Sign-up**: [https://tavily.com/](https://tavily.com/)
* **Key Type**: API Key
* **Env Variable**: `TAVILY_API_KEY`
* **Cost**: Free tier (1k requests/month).

### Firecrawl (Web Scraping)

* **Service**: Firecrawl
* **Sign-up**: [https://www.firecrawl.dev/](https://www.firecrawl.dev/)
* **Key Type**: API Key
* **Env Variable**: `FIRECRAWL_API_KEY`
* **Cost**: Free tier available.

## 3. Database & Memory

### Qdrant (Vector Database)

* **Service**: Qdrant Cloud (or local Docker)
* **Sign-up**: [https://cloud.qdrant.io/](https://cloud.qdrant.io/) (for managed)
* **Key Type**: API Key & URL
* **Env Variables**: `QDRANT_URL`, `QDRANT_API_KEY`
* **Cost**: Free tier (1 cluster). Local Docker is free.

### Mem0 (Memory Layer)

* **Service**: Mem0 Platform
* **Sign-up**: [https://mem0.ai/](https://mem0.ai/)
* **Key Type**: API Key
* **Env Variable**: `MEM0_API_KEY`
* **Cost**: Free tier available.

## 4. Monitoring & Observability

### Sentry (Error Tracking)

* **Service**: Sentry
* **Sign-up**: [https://sentry.io/](https://sentry.io/)
* **Key Type**: DSN (Data Source Name)
* **Env Variable**: `SENTRY_DSN`
* **Cost**: Free developer tier.

## 5. Development Tools

### GitHub (Code & Issues)

* **Service**: GitHub Developer Settings
* **Sign-up**: [https://github.com/settings/tokens](https://github.com/settings/tokens)
* **Key Type**: Personal Access Token (Classic or Fine-grained)
* **Env Variable**: `GITHUB_TOKEN`
* **Scopes Needed**: `repo`, `read:org`, `workflow`.

## Setup Instructions

1. **Copy the Example**: `cp example.env .env`
2. **Fill Config**: Open `.env` and paste your acquired keys.
3. **Secure**: Never commit `.env` to version control (ensure it is in `.gitignore`).
4. **Load Secrets**: Run `Scripts/set-mcp-secrets.ps1` to load these into your environment/Docker context.
