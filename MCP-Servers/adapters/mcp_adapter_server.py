#!/usr/bin/env python3
"""Local fallback MCP adapters for servers without stable upstream Docker images."""

from __future__ import annotations

import argparse
import json
import os
import pathlib
import re
import xml.etree.ElementTree as ET
from typing import Any

from mcp.server.fastmcp import FastMCP


ROOT_DEFAULT = "/workspace"
_RAG_INDEX: dict[str, str] = {}
TEXT_EXTENSIONS = {
    ".c",
    ".cc",
    ".cpp",
    ".cs",
    ".css",
    ".go",
    ".h",
    ".hpp",
    ".html",
    ".java",
    ".js",
    ".json",
    ".jsx",
    ".md",
    ".mjs",
    ".py",
    ".rb",
    ".rs",
    ".sql",
    ".swift",
    ".toml",
    ".ts",
    ".tsx",
    ".txt",
    ".yaml",
    ".yml",
}


def _to_safe_root(path: str) -> pathlib.Path:
    candidate = pathlib.Path(path).resolve()
    workspace = pathlib.Path(ROOT_DEFAULT).resolve()
    if workspace in candidate.parents or candidate == workspace:
        return candidate
    return workspace


def _iter_files(root: pathlib.Path, max_files: int, max_size_bytes: int = 512 * 1024):
    count = 0
    for item in root.rglob("*"):
        if count >= max_files:
            break
        if not item.is_file():
            continue
        if item.suffix.lower() not in TEXT_EXTENSIONS:
            continue
        try:
            if item.stat().st_size > max_size_bytes:
                continue
        except OSError:
            continue
        count += 1
        yield item


def _read_text(path: pathlib.Path) -> str:
    try:
        return path.read_text(encoding="utf-8", errors="ignore")
    except OSError:
        return ""


def _line_number(content: str, offset: int) -> int:
    return content.count("\n", 0, offset) + 1


def register_augments(mcp: FastMCP) -> None:
    docs = {
        "react": "https://react.dev/",
        "nextjs": "https://nextjs.org/docs",
        "vue": "https://vuejs.org/guide/introduction.html",
        "svelte": "https://svelte.dev/docs",
        "angular": "https://angular.dev/overview",
        "tailwind": "https://tailwindcss.com/docs",
        "node": "https://nodejs.org/docs/latest/api/",
        "python": "https://docs.python.org/3/",
    }

    @mcp.tool()
    def list_framework_docs() -> dict[str, Any]:
        return {"frameworks": docs}

    @mcp.tool()
    def find_framework_doc(framework: str) -> dict[str, Any]:
        key = framework.strip().lower()
        if key in docs:
            return {"framework": key, "url": docs[key], "found": True}
        close = [name for name in docs.keys() if key in name or name in key]
        return {"framework": key, "found": False, "suggestions": close}


def register_arxiv(mcp: FastMCP) -> None:
    import requests

    @mcp.tool()
    def arxiv_search(query: str, max_results: int = 10) -> dict[str, Any]:
        limit = max(1, min(max_results, 25))
        response = requests.get(
            "http://export.arxiv.org/api/query",
            params={"search_query": f"all:{query}", "start": 0, "max_results": limit},
            timeout=30,
        )
        if not response.ok:
            return {"ok": False, "status_code": response.status_code, "error": response.text[:400]}
        root = ET.fromstring(response.text)
        namespace = {"atom": "http://www.w3.org/2005/Atom"}
        entries = []
        for entry in root.findall("atom:entry", namespace):
            entries.append(
                {
                    "id": (entry.findtext("atom:id", default="", namespaces=namespace) or "").strip(),
                    "title": (entry.findtext("atom:title", default="", namespaces=namespace) or "").strip(),
                    "summary": (entry.findtext("atom:summary", default="", namespaces=namespace) or "").strip()[:600],
                }
            )
        return {"ok": True, "query": query, "count": len(entries), "results": entries}


def register_searxng(mcp: FastMCP) -> None:
    import requests

    @mcp.tool()
    def searxng_search(query: str, page: int = 1) -> dict[str, Any]:
        base_url = os.getenv("SEARXNG_URL", "").strip()
        if not base_url or base_url == "<UNKNOWN>":
            return {
                "ok": False,
                "error": "SEARXNG_URL is not configured. Set searxng.url secret or SEARXNG_URL.",
            }
        response = requests.get(
            f"{base_url.rstrip('/')}/search",
            params={"q": query, "format": "json", "pageno": max(1, page)},
            timeout=30,
        )
        if not response.ok:
            return {"ok": False, "status_code": response.status_code, "error": response.text[:400]}
        data = response.json()
        results = data.get("results", [])[:15]
        normalized = [
            {"title": item.get("title"), "url": item.get("url"), "content": item.get("content", "")[:240]}
            for item in results
        ]
        return {"ok": True, "query": query, "result_count": len(normalized), "results": normalized}


def register_nexus(mcp: FastMCP) -> None:
    @mcp.tool()
    def nexus_health() -> dict[str, Any]:
        key = os.getenv("OPENROUTER_API_KEY") or os.getenv("NEXUS_API_KEY")
        return {"ok": bool(key and key != "<UNKNOWN>"), "has_api_key": bool(key and key != "<UNKNOWN>")}

    @mcp.tool()
    def nexus_search(query: str) -> dict[str, Any]:
        key = os.getenv("OPENROUTER_API_KEY") or os.getenv("NEXUS_API_KEY")
        if not key or key == "<UNKNOWN>":
            return {
                "ok": False,
                "error": "Missing OPENROUTER_API_KEY or NEXUS_API_KEY",
                "query": query,
            }
        return {
            "ok": True,
            "query": query,
            "message": "API key is present. Use upstream nexus-mcp for full search and citation tooling.",
        }


def register_cloudflare(mcp: FastMCP) -> None:
    import requests

    def _headers() -> dict[str, str]:
        token = os.getenv("CLOUDFLARE_API_TOKEN", "").strip()
        if not token:
            return {}
        return {"Authorization": f"Bearer {token}", "Content-Type": "application/json"}

    @mcp.tool()
    def cloudflare_health() -> dict[str, Any]:
        has_token = bool(os.getenv("CLOUDFLARE_API_TOKEN"))
        has_account = bool(os.getenv("CLOUDFLARE_ACCOUNT_ID"))
        return {
            "ok": has_token,
            "has_api_token": has_token,
            "has_account_id": has_account,
            "message": "Set CLOUDFLARE_API_TOKEN for live API access.",
        }

    @mcp.tool()
    def cloudflare_list_zones(page: int = 1, per_page: int = 20) -> dict[str, Any]:
        headers = _headers()
        if not headers:
            return {"ok": False, "error": "Missing CLOUDFLARE_API_TOKEN"}
        response = requests.get(
            "https://api.cloudflare.com/client/v4/zones",
            headers=headers,
            timeout=30,
            params={"page": max(page, 1), "per_page": max(1, min(per_page, 50))},
        )
        data = response.json()
        zones = [
            {"id": z.get("id"), "name": z.get("name"), "status": z.get("status")}
            for z in data.get("result", [])
        ]
        return {"ok": response.ok, "zones": zones, "status_code": response.status_code}

    @mcp.tool()
    def cloudflare_get_account() -> dict[str, Any]:
        headers = _headers()
        account_id = os.getenv("CLOUDFLARE_ACCOUNT_ID", "").strip()
        if not headers:
            return {"ok": False, "error": "Missing CLOUDFLARE_API_TOKEN"}
        if not account_id:
            return {"ok": False, "error": "Missing CLOUDFLARE_ACCOUNT_ID"}
        response = requests.get(
            f"https://api.cloudflare.com/client/v4/accounts/{account_id}",
            headers=headers,
            timeout=30,
        )
        payload = response.json()
        result = payload.get("result") if isinstance(payload, dict) else None
        return {"ok": response.ok, "account": result, "status_code": response.status_code}


def register_filescope(mcp: FastMCP) -> None:
    import_re = re.compile(
        r"^\s*(?:from\s+([A-Za-z0-9_./-]+)\s+import|import\s+([A-Za-z0-9_.,\s/-]+))",
        re.MULTILINE,
    )

    @mcp.tool()
    def filescope_scan(root_path: str = ROOT_DEFAULT, max_files: int = 800) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        edge_counts: dict[str, int] = {}
        scanned = 0
        for path in _iter_files(root, max_files):
            scanned += 1
            content = _read_text(path)
            for match in import_re.finditer(content):
                dep = (match.group(1) or match.group(2) or "").split(",")[0].strip()
                if not dep:
                    continue
                edge_counts[dep] = edge_counts.get(dep, 0) + 1
        top = sorted(edge_counts.items(), key=lambda item: item[1], reverse=True)[:30]
        return {"root": str(root), "files_scanned": scanned, "top_dependencies": top}

    @mcp.tool()
    def filescope_priority_files(root_path: str = ROOT_DEFAULT, max_files: int = 1200) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        scored: list[tuple[int, str]] = []
        hot_names = ("index", "main", "app", "server", "routes", "router", "config")
        for path in _iter_files(root, max_files):
            rel = str(path.relative_to(root)).replace("\\", "/")
            name = path.stem.lower()
            score = 0
            if any(token in name for token in hot_names):
                score += 5
            if "/src/" in rel or rel.startswith("src/"):
                score += 3
            if rel.endswith((".ts", ".tsx", ".py", ".go", ".rs", ".java")):
                score += 2
            if rel.endswith((".json", ".md", ".lock")):
                score -= 1
            scored.append((score, rel))
        top = [entry[1] for entry in sorted(scored, reverse=True)[:40]]
        return {"root": str(root), "important_files": top}


def register_gitleaks(mcp: FastMCP) -> None:
    patterns = {
        "aws_access_key": re.compile(r"\b(AKIA|ASIA)[A-Z0-9]{16}\b"),
        "github_token": re.compile(r"\bgh[pousr]_[A-Za-z0-9]{36,255}\b"),
        "slack_token": re.compile(r"\bxox[baprs]-[A-Za-z0-9-]{10,}\b"),
        "private_key": re.compile(r"-----BEGIN (?:RSA|EC|OPENSSH|PRIVATE) KEY-----"),
        "generic_api_key": re.compile(
            r"(?i)\b(api[_-]?key|secret|token)\b\s*[:=]\s*['\"]?[A-Za-z0-9_\-]{16,}"
        ),
    }

    @mcp.tool()
    def gitleaks_scan(root_path: str = ROOT_DEFAULT, max_files: int = 2000) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        findings: list[dict[str, Any]] = []
        for path in _iter_files(root, max_files, max_size_bytes=256 * 1024):
            rel = str(path.relative_to(root)).replace("\\", "/")
            content = _read_text(path)
            for key, regex in patterns.items():
                for match in regex.finditer(content):
                    findings.append(
                        {
                            "rule": key,
                            "file": rel,
                            "line": _line_number(content, match.start()),
                            "snippet": match.group(0)[:120],
                        }
                    )
                    if len(findings) >= 300:
                        break
                if len(findings) >= 300:
                    break
            if len(findings) >= 300:
                break
        return {"root": str(root), "finding_count": len(findings), "findings": findings[:80]}


def register_react(mcp: FastMCP) -> None:
    @mcp.tool()
    def react_list_components(root_path: str = ROOT_DEFAULT, max_files: int = 1000) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        components: list[str] = []
        for path in _iter_files(root, max_files):
            if path.suffix.lower() not in {".jsx", ".tsx"}:
                continue
            content = _read_text(path)
            if "React" in content or "export default" in content or "function " in content:
                components.append(str(path.relative_to(root)).replace("\\", "/"))
        return {"root": str(root), "components": components[:300], "count": len(components)}

    @mcp.tool()
    def react_create_component(
        component_name: str,
        directory: str = f"{ROOT_DEFAULT}/src/components",
        use_typescript: bool = True,
    ) -> dict[str, Any]:
        safe_dir = _to_safe_root(directory)
        safe_dir.mkdir(parents=True, exist_ok=True)
        extension = "tsx" if use_typescript else "jsx"
        target = safe_dir / f"{component_name}.{extension}"
        if target.exists():
            return {"ok": False, "error": f"{target} already exists"}
        if use_typescript:
            content = (
                "type Props = { className?: string };\n\n"
                f"export function {component_name}({{ className }}: Props) {{\n"
                "  return <div className={className}>TODO: implement</div>;\n"
                "}\n"
            )
        else:
            content = (
                f"export function {component_name}({{ className }}) {{\n"
                "  return <div className={className}>TODO: implement</div>;\n"
                "}\n"
            )
        target.write_text(content, encoding="utf-8")
        return {"ok": True, "file": str(target)}

    @mcp.tool()
    def react_update_component(file_path: str, content: str) -> dict[str, Any]:
        target = _to_safe_root(file_path)
        if not target.exists():
            return {"ok": False, "error": f"{target} does not exist"}
        target.write_text(content, encoding="utf-8")
        return {"ok": True, "file": str(target), "bytes": len(content.encode("utf-8"))}


def register_vue(mcp: FastMCP) -> None:
    @mcp.tool()
    def vue_list_components(root_path: str = ROOT_DEFAULT, max_files: int = 1000) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        components: list[str] = []
        for path in _iter_files(root, max_files):
            if path.suffix.lower() != ".vue":
                continue
            components.append(str(path.relative_to(root)).replace("\\", "/"))
        return {"root": str(root), "components": components[:400], "count": len(components)}

    @mcp.tool()
    def vue_create_component(component_name: str, directory: str = f"{ROOT_DEFAULT}/src/components") -> dict[str, Any]:
        safe_dir = _to_safe_root(directory)
        safe_dir.mkdir(parents=True, exist_ok=True)
        target = safe_dir / f"{component_name}.vue"
        if target.exists():
            return {"ok": False, "error": f"{target} already exists"}
        content = (
            "<template>\n"
            "  <div class=\"component-root\">TODO: implement</div>\n"
            "</template>\n\n"
            "<script setup lang=\"ts\">\n"
            "</script>\n\n"
            "<style scoped>\n"
            ".component-root {\n"
            "}\n"
            "</style>\n"
        )
        target.write_text(content, encoding="utf-8")
        return {"ok": True, "file": str(target)}


def register_shadcn(mcp: FastMCP) -> None:
    presets = {
        "button": "export function Button() { return <button className=\"px-4 py-2 rounded-md border\">Button</button>; }",
        "card": "export function Card({ children }) { return <div className=\"rounded-xl border p-4 shadow-sm\">{children}</div>; }",
        "badge": "export function Badge({ children }) { return <span className=\"rounded-full border px-2 py-0.5 text-xs\">{children}</span>; }",
    }

    @mcp.tool()
    def shadcn_list_components() -> dict[str, Any]:
        return {"components": sorted(presets.keys())}

    @mcp.tool()
    def shadcn_get_component(name: str) -> dict[str, Any]:
        key = name.strip().lower()
        if key not in presets:
            return {"ok": False, "error": f"Unknown component '{name}'", "available": sorted(presets.keys())}
        return {"ok": True, "name": key, "tsx": presets[key]}


def register_lsmcp(mcp: FastMCP) -> None:
    symbol_re = re.compile(
        r"^\s*(?:export\s+)?(?:async\s+)?(?:function|class|const|let|var|interface|type)\s+([A-Za-z_][A-Za-z0-9_]*)",
        re.MULTILINE,
    )

    @mcp.tool()
    def lsmcp_symbols(root_path: str = ROOT_DEFAULT, max_files: int = 600) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        results = []
        for path in _iter_files(root, max_files):
            if path.suffix.lower() not in {".js", ".jsx", ".ts", ".tsx", ".mjs", ".cjs"}:
                continue
            content = _read_text(path)
            symbols = symbol_re.findall(content)
            if not symbols:
                continue
            results.append(
                {
                    "file": str(path.relative_to(root)).replace("\\", "/"),
                    "symbols": symbols[:50],
                }
            )
        return {"root": str(root), "files": results[:300], "count": len(results)}


def register_codegraph(mcp: FastMCP) -> None:
    function_re = re.compile(r"^\s*(?:def|function|export\s+function)\s+([A-Za-z_][A-Za-z0-9_]*)", re.MULTILINE)
    class_re = re.compile(r"^\s*(?:class|export\s+class)\s+([A-Za-z_][A-Za-z0-9_]*)", re.MULTILINE)
    import_re = re.compile(r"^\s*(?:from\s+([A-Za-z0-9_./-]+)\s+import|import\s+([A-Za-z0-9_.,\s/-]+))", re.MULTILINE)

    @mcp.tool()
    def codegraph_index(root_path: str = ROOT_DEFAULT, max_files: int = 900) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        files = []
        edges = []
        for path in _iter_files(root, max_files):
            content = _read_text(path)
            rel = str(path.relative_to(root)).replace("\\", "/")
            functions = function_re.findall(content)
            classes = class_re.findall(content)
            if functions or classes:
                files.append({"file": rel, "functions": functions[:30], "classes": classes[:30]})
            for match in import_re.finditer(content):
                target = (match.group(1) or match.group(2) or "").split(",")[0].strip()
                if target:
                    edges.append({"from": rel, "to": target})
        return {"root": str(root), "node_count": len(files), "edge_count": len(edges), "nodes": files[:400], "edges": edges[:600]}


def register_ragdocs(mcp: FastMCP) -> None:
    @mcp.tool()
    def ragdocs_index(root_path: str = ROOT_DEFAULT, max_files: int = 600) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        indexed = 0
        for path in _iter_files(root, max_files):
            content = _read_text(path)
            if not content.strip():
                continue
            key = str(path.relative_to(root)).replace("\\", "/")
            _RAG_INDEX[key] = content[:12000]
            indexed += 1
        return {"root": str(root), "indexed_count": indexed, "total_indexed": len(_RAG_INDEX)}

    @mcp.tool()
    def ragdocs_search(query: str, max_results: int = 10) -> dict[str, Any]:
        if not _RAG_INDEX:
            return {"ok": False, "error": "No indexed documents. Run ragdocs_index first."}
        key = query.lower()
        scored: list[tuple[int, str, str]] = []
        for path, content in _RAG_INDEX.items():
            lower = content.lower()
            score = lower.count(key)
            if score <= 0:
                continue
            idx = lower.find(key)
            snippet = content[max(0, idx - 120): idx + 220]
            scored.append((score, path, snippet))
        scored.sort(reverse=True)
        payload = [
            {"file": path, "score": score, "snippet": snippet}
            for score, path, snippet in scored[: max(1, min(max_results, 30))]
        ]
        return {"ok": True, "query": query, "results": payload, "count": len(payload)}


def register_semgrep(mcp: FastMCP) -> None:
    suspicious = {
        "eval": re.compile(r"\beval\s*\("),
        "exec": re.compile(r"\bexec\s*\("),
        "hardcoded_password": re.compile(r"(?i)\b(password|passwd|pwd)\b\s*[:=]\s*['\"].+['\"]"),
        "http_no_tls": re.compile(r"(?i)http://[A-Za-z0-9._/-]+"),
    }

    @mcp.tool()
    def semgrep_scan_local(root_path: str = ROOT_DEFAULT, max_files: int = 1000) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        findings = []
        for path in _iter_files(root, max_files):
            content = _read_text(path)
            rel = str(path.relative_to(root)).replace("\\", "/")
            for rule_name, regex in suspicious.items():
                for match in regex.finditer(content):
                    findings.append(
                        {
                            "rule": rule_name,
                            "file": rel,
                            "line": _line_number(content, match.start()),
                            "snippet": match.group(0)[:120],
                        }
                    )
                    if len(findings) >= 500:
                        break
                if len(findings) >= 500:
                    break
            if len(findings) >= 500:
                break
        return {"root": str(root), "finding_count": len(findings), "findings": findings[:150]}

    @mcp.tool()
    def semgrep_rule_schema() -> dict[str, Any]:
        return {"rules": list(suspicious.keys())}


def register_repomapper(mcp: FastMCP) -> None:
    function_re = re.compile(r"^\s*(?:def|function|export\s+function)\s+([A-Za-z_][A-Za-z0-9_]*)", re.MULTILINE)
    class_re = re.compile(r"^\s*(?:class|export\s+class)\s+([A-Za-z_][A-Za-z0-9_]*)", re.MULTILINE)

    @mcp.tool()
    def repomapper_build(root_path: str = ROOT_DEFAULT, max_files: int = 800) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        mapped: list[dict[str, Any]] = []
        for path in _iter_files(root, max_files):
            content = _read_text(path)
            functions = function_re.findall(content)
            classes = class_re.findall(content)
            if not functions and not classes:
                continue
            mapped.append(
                {
                    "file": str(path.relative_to(root)).replace("\\", "/"),
                    "functions": functions[:30],
                    "classes": classes[:30],
                }
            )
        return {"root": str(root), "files": mapped[:400], "mapped_count": len(mapped)}


def register_snyk(mcp: FastMCP) -> None:
    @mcp.tool()
    def snyk_scan_manifest(manifest_path: str) -> dict[str, Any]:
        path = _to_safe_root(manifest_path)
        if not path.exists():
            return {"ok": False, "error": f"{path} not found"}
        content = _read_text(path)
        if not content:
            return {"ok": False, "error": f"{path} is empty or unreadable"}
        issues: list[dict[str, Any]] = []
        if path.name == "package.json":
            try:
                data = json.loads(content)
            except json.JSONDecodeError as exc:
                return {"ok": False, "error": f"Invalid package.json: {exc}"}
            deps = {}
            deps.update(data.get("dependencies", {}))
            deps.update(data.get("devDependencies", {}))
            for name, version in deps.items():
                risk = "unknown"
                if "latest" in str(version) or version in {"*", "x"}:
                    risk = "high"
                elif str(version).startswith("^0"):
                    risk = "medium"
                issues.append({"dependency": name, "version": str(version), "risk": risk})
        elif path.name in {"requirements.txt", "Pipfile", "pyproject.toml"}:
            for line in content.splitlines():
                clean = line.strip()
                if not clean or clean.startswith("#"):
                    continue
                risk = "medium" if "==" not in clean else "low"
                issues.append({"dependency": clean, "risk": risk})
        return {"ok": True, "manifest": str(path), "issue_count": len(issues), "issues": issues[:300]}

    @mcp.tool()
    def snyk_scan_workspace(root_path: str = ROOT_DEFAULT, max_files: int = 2000) -> dict[str, Any]:
        root = _to_safe_root(root_path)
        manifests = []
        for item in root.rglob("*"):
            if len(manifests) >= max_files:
                break
            if item.name in {"package.json", "requirements.txt", "Pipfile", "pyproject.toml"}:
                manifests.append(str(item.relative_to(root)).replace("\\", "/"))
        return {"root": str(root), "manifest_count": len(manifests), "manifests": manifests[:500]}


def register_docker_mcp(mcp: FastMCP) -> None:
    import docker as docker_sdk

    @mcp.tool()
    def docker_health() -> dict[str, Any]:
        try:
            client = docker_sdk.from_env()
            ok = client.ping()
            return {"ok": bool(ok), "socket": os.getenv("DOCKER_HOST", "unix:///var/run/docker.sock")}
        except Exception as exc:  # noqa: BLE001
            return {"ok": False, "error": str(exc)}

    @mcp.tool()
    def docker_list_containers(all_containers: bool = True, limit: int = 50) -> dict[str, Any]:
        try:
            client = docker_sdk.from_env()
            containers = client.containers.list(all=all_containers)
            payload = []
            for item in containers[: max(1, min(limit, 200))]:
                payload.append(
                    {
                        "id": item.short_id,
                        "name": item.name,
                        "status": item.status,
                        "image": item.image.tags[0] if item.image.tags else item.image.short_id,
                    }
                )
            return {"ok": True, "count": len(payload), "containers": payload}
        except Exception as exc:  # noqa: BLE001
            return {"ok": False, "error": str(exc)}

    @mcp.tool()
    def docker_list_images(limit: int = 80) -> dict[str, Any]:
        try:
            client = docker_sdk.from_env()
            images = client.images.list()
            payload = []
            for image in images[: max(1, min(limit, 300))]:
                payload.append(
                    {
                        "id": image.short_id,
                        "tags": image.tags,
                    }
                )
            return {"ok": True, "count": len(payload), "images": payload}
        except Exception as exc:  # noqa: BLE001
            return {"ok": False, "error": str(exc)}


def build_server(mode: str) -> FastMCP:
    mcp = FastMCP(f"{mode}-adapter")

    @mcp.tool()
    def adapter_health() -> dict[str, Any]:
        return {"mode": mode, "status": "ok", "workspace": ROOT_DEFAULT}

    if mode == "augments":
        register_augments(mcp)
    elif mode == "arxiv":
        register_arxiv(mcp)
    elif mode == "cloudflare":
        register_cloudflare(mcp)
    elif mode == "codegraph":
        register_codegraph(mcp)
    elif mode == "filescopemcp":
        register_filescope(mcp)
    elif mode == "lsmcp":
        register_lsmcp(mcp)
    elif mode == "gitleaks":
        register_gitleaks(mcp)
    elif mode == "nexus":
        register_nexus(mcp)
    elif mode == "ragdocs":
        register_ragdocs(mcp)
    elif mode == "react":
        register_react(mcp)
    elif mode == "repomapper":
        register_repomapper(mcp)
    elif mode == "semgrep":
        register_semgrep(mcp)
    elif mode == "searxng":
        register_searxng(mcp)
    elif mode == "shadcn":
        register_shadcn(mcp)
    elif mode == "snyk":
        register_snyk(mcp)
    elif mode == "vue":
        register_vue(mcp)
    elif mode == "docker-mcp":
        register_docker_mcp(mcp)
    else:
        raise ValueError(f"Unsupported adapter mode: {mode}")
    return mcp


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Run a fallback MCP adapter server.")
    parser.add_argument(
        "--mode",
        required=True,
        choices=[
            "augments",
            "arxiv",
            "cloudflare",
            "codegraph",
            "docker-mcp",
            "filescopemcp",
            "gitleaks",
            "lsmcp",
            "nexus",
            "ragdocs",
            "react",
            "repomapper",
            "searxng",
            "semgrep",
            "shadcn",
            "snyk",
            "vue",
        ],
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    server = build_server(args.mode)
    server.run()


if __name__ == "__main__":
    main()
