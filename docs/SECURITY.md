# 🔒 Esprit Security Architecture & Policy

Security, privacy, and air-gapped isolation are core design requirements of Esprit.

---

## 1. Security Architecture Principles

### 1.1 True Local-First & Air-Gap Defense
* Esprit executes all models, embeddings, indexing, AST parsing, and cleaner diagnostics **100% locally on your machine**.
* Zero telemetry is transmitted to third-party endpoints.
* Air-gap mode (`ESPRIT_OFFLINE=1`) hard-disables socket creation and network interfaces at runtime.

### 1.2 High-Entropy Secret Scanner
The built-in credential scanner detects leaked keys before code is committed or pushed:
* **Shannon Entropy Analysis**: Flags strings with entropy > 4.5 and length > 20 characters.
* **Pattern Heuristics**: AWS Access Keys (`AKIA...`), GitHub Personal Access Tokens (`ghp_...`), Google Cloud Platform Keys (`AIza...`), Slack Tokens (`xoxb-...`), OpenAI & Anthropic keys, Stripe live keys, RSA/SSH private keys, and database connection strings.

### 1.3 Cryptographic Merkle Audit Trail
All high-impact system mutations are signed into an append-only cryptographic Merkle audit log. Each audit block verifies the SHA-256 hash of the previous state, preventing unauthorized modification or log tampering.

### 1.4 WebAssembly (WASM) Sandbox Isolation
User-defined or third-party plugins execute inside a strict `wasmtime` sandbox with:
* No network socket access
* Capability-based read-only filesystem mounts
* Deterministic memory allocation ceilings

---

## 2. Reporting Security Vulnerabilities

If you discover a security issue or vulnerability in Esprit:
1. Do **not** open a public issue on GitHub.
2. Email maintainer **Kartavya Singh** directly at `kartxvyaa@gmail.com`.
3. Include a description of the issue, reproduction steps, and potential impact.
4. We aim to acknowledge reports within 24–48 hours and provide patches promptly.
