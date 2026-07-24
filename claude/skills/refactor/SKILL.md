---
name: refactor
description: Improve code structure while preserving public behavior and interfaces.
---

# Refactor Safely

1. Read the target and identify its public interfaces, observable behavior, side effects, and exception semantics.
2. Locate tests and repository conventions. Add characterization coverage first when behavior-sensitive code lacks adequate tests.
3. Improve cohesion, naming, types, documentation, repetition, modularity, dead code, and unhelpful comments without changing behavior.
4. Use language features appropriate to the project's supported version. Use `match` only when it improves clarity.
5. Run the narrowest relevant tests, then broader checks when appropriate.
6. Summarize the refactor and verification.

Do not change public APIs or behavior unless the user explicitly authorizes it.
