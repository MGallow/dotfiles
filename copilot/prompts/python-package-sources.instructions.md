---
description: "Use when installing Python packages with uv or uvx, configuring Python MCP launchers, finding a company package mirror, or diagnosing PyPI download and TLS failures."
---

# Python package sources

- Use `uv`, not pip or Poetry. Preserve package sources explicitly configured
  by the environment, including `UV_INDEX`, `UV_DEFAULT_INDEX`, and
  `PIP_INDEX_URL`; do not print credentials contained in their values.
- For CH Robinson work without another explicitly configured source, use the
  company Python mirror:
  `https://artifactory.chrobinson.com/artifactory/api/pypi/pypi/simple`.
  This source is verified in the TCE Inspector repository's `pyproject.toml`,
  Dependabot registry, and CI `CHRArtifactory - Pip` service connection.
- Inspect both `[tool.uv].extra-index-url` and `[[tool.uv.index]]`, plus CI and
  registry configuration, before concluding that no package mirror exists.
- Isolated `uv tool run` / `uvx` launches do not inherit project index settings.
  Pass `--default-index` with the company mirror when no runner source overrides
  it. Keep tool-only packages out of application dependencies and lockfiles.
- Internal access is not guaranteed. Check reachability and supported
  authentication without exposing secrets; never hardcode credentials.
- During MLflow setup on 2026-10-07, Cisco Umbrella blocked
  `files.pythonhosted.org`: DNS resolved to a block-page address, curl returned
  HTTP 403 with `Server: Cisco Umbrella`, and uv reported a TLS handshake
  failure. Installation succeeded through Artifactory. Treat this as diagnostic
  history, not an assumption that every TLS error has the same cause.
- `--system-certs` enables platform certificate trust but cannot fix a network
  block. Never disable TLS verification, override DNS to evade policy, or use
  an unapproved mirror. Use the approved source or request IT assistance.
