---
description: "Use when working with MLflow experiments, runs, GenAI traces, assessments, or configuring and troubleshooting the user-level mlflow-mcp server."
---

# User-level MLflow MCP

- The configured tracking service is `https://mlflow-api.gen-ai.chr.io`.
  Prefer the available `mlflow-mcp` tools for supported MLflow operations;
  do not launch a separate terminal MCP client for every ordinary query.
- The server is registered in the active VS Code Insiders user profile, not
  this repository. Open it with **MCP: Open User Configuration**. The default
  profile file is
  `/Users/GALLMAT/Library/Application Support/Code - Insiders/User/mcp.json`.
  Preserve existing servers and inputs, and do not create duplicate workspace
  registrations. Other profiles may have different configuration files.
- MLflow uses a local stdio MCP process connecting to the tracking service;
  the tracking URL is not a direct HTTP MCP endpoint. Keep its CLI isolated
  from application dependencies.
- The working launcher is:

  ```sh
  /opt/homebrew/anaconda3/bin/uv --system-certs tool run \
    --default-index https://artifactory.chrobinson.com/artifactory/api/pypi/pypi/simple \
    --from 'mlflow[mcp]>=3.5.1' mlflow mcp run
  ```

  Its environment sets `MLFLOW_TRACKING_URI` to the tracking URL above and
  `MLFLOW_MCP_TOOLS=genai`. Verify the local uv path if it changes or when
  working on another machine. Preserve explicitly configured runner sources.
- Start or inspect the server through **MCP: List Servers**. If tools are
  unavailable, check server state, trust, tool selection, and output before
  modifying the registration. Do not claim chat availability based solely on
  a successful standalone CLI test.
- GenAI tools include reads, writes, and deletions; this is not a read-only
  configuration. Setup tests should only list/search data. Perform mutations
  only when requested, and confirm destructive scope when it is unclear.
- Setup was verified on 2026-10-07 with MCP initialization, discovery of 26
  tools, and a successful experiment search through MCP. Tool counts can
  change with MLflow versions. No credentials were needed for that test;
  recheck authentication if access changes and never store secrets in plaintext.
