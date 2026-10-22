# 🏛️ Esprit Architectural Specification

Esprit is an autonomous developer operating layer and workspace intelligence engine engineered in Rust. It runs locally with hardware-accelerated inference, sub-millisecond lexical search, semantic vector retrieval, deep AST code intelligence, and a system maintenance cleaner.

---

## 1. System Architecture Overview

```
                                      ┌──────────────────────────────────────┐
                                      │        User Interfaces & IPC         │
                                      │  CLI (clap) │ TUI (ratatui) │ LSP   │
                                      └──────────────────┬───────────────────┘
                                                         │
                                      ┌──────────────────▼───────────────────┐
                                      │           Core Orchestrator          │
                                      │       apps/esprit-cli & daemon       │
                                      └─┬──────────────┬──────────────┬──────┘
                                        │              │              │
             ┌──────────────────────────┴───┐          │          ┌───┴──────────────────────────┐
             │       Inference & RAG        │          │          │      System & Maintenance     │
             ├──────────────────────────────┤          │          ├──────────────────────────────┤
             │ crates/esprit-ai (llama.cpp) │          │          │ crates/esprit-cleaner        │
             │ crates/esprit-models (GGUF)  │          │          │ crates/esprit-security       │
             │ crates/esprit-embeddings     │          │          │ crates/esprit-platform       │
             │ crates/esprit-rag (HyDE)     │          │          │ crates/esprit-filesystem     │
             └──────────────────────────────┘          │          └──────────────────────────────┘
                                                       │
                                      ┌────────────────▼─────────────────────┐
                                      │    Code Intelligence & Knowledge     │
                                      ├──────────────────────────────────────┤
                                      │ crates/esprit-codeintel (AST/Radius) │
                                      │ crates/esprit-index (Tantivy/BM25)   │
                                      │ crates/esprit-vectors (Cosine Sim)   │
                                      │ crates/esprit-memory (SQLite WAL)    │
                                      │ crates/esprit-workflows & agents     │
                                      └──────────────────────────────────────┘
```

---

## 2. Core Subsystems & Workspace Crates

### 2.1 Interface & Application Layer
* **`apps/esprit-cli`**: The primary user-facing binary (`esprit`). Provides interactive command routing, ANSI styling (`ui.rs`), JSON formatting, stdio JSON-RPC 2.0 Language Server Protocol (`lsp.rs`), background daemon invocation, and self-updater.
* **`desktop`**: Native GUI frontend binding for macOS, Linux, and Windows.

### 2.2 Inference & Retrieval Subsystem
* **`crates/esprit-ai`**: Native Rust bindings to `llama.cpp`. Handles GGUF model execution with automatic hardware offloading to Apple Silicon Metal (MPS) on macOS and optimized multi-threaded AVX2/NEON on Linux/Windows.
* **`crates/esprit-models`**: Model registry, resumable chunked HTTPS downloader, SHA-256 integrity verification, and local cache manager.
* **`crates/esprit-embeddings`**: Extract semantic embedding vectors from source code chunks and natural language queries.
* **`crates/esprit-rag`**: Hybrid search combining BM25 keyword matching with dense vector nearest-neighbour lookups and Hypothetical Document Embeddings (HyDE).

### 2.3 Code Intelligence & AST Graphs
* **`crates/esprit-codeintel`**: Polyglot AST symbol parsing (Rust, TypeScript/JavaScript, Python, Go), cross-file blast radius calculation, downstream test impact analysis, and cognitive/cyclomatic complexity evaluation.
* **`crates/esprit-index`**: Full-text BM25 index powered by Tantivy with real-time incremental re-indexing.
* **`crates/esprit-vectors`**: Compact vector storage with cosine similarity search and exportable brain packages (`.esprit_brain.json`).
* **`crates/esprit-memory`**: SQLite WAL conversational history storage with session memory compression.

### 2.4 System Maintenance & Security
* **`crates/esprit-cleaner`**: Deep system cache sweeper, ghost application remnant scanner, and malware/persistence heuristic detector with unified memory and swap monitoring.
* **`crates/esprit-security`**: Shannon entropy secret scanner (detects AWS, GitHub, GCP, Stripe, SSH credentials), Merkle tree audit logging, and air-gap network enforcement.
* **`crates/esprit-filesystem`**: Cryptographic file deduplication (SHA-256) and directory organization engine.
* **`crates/esprit-platform`**: OS hardware discovery, thermal telemetry, system doctor diagnostic checks, and filesystem notification watchers.
* **`crates/esprit-plugins`**: WebAssembly (WASM) plugin sandbox isolated by `wasmtime`.

---

## 3. Storage Hierarchy & Protocols

All persistent state is stored in strict conformance with standard OS specifications:

| Platform | Path | Purpose |
| :--- | :--- | :--- |
| **macOS** | `~/Library/Application Support/dev.esprit.esprit/` | Index databases, vector embeddings, config |
| **Linux** | `~/.config/esprit/` and `~/.local/share/esprit/` | XDG Base Directory compliant storage |
| **Windows** | `%APPDATA%\esprit\esprit\` | Windows roaming configuration and indexes |

### SQLite Concurrency Model
All SQLite databases operate with:
* `PRAGMA journal_mode = WAL;` (Write-Ahead Logging for zero-lock reads)
* `PRAGMA synchronous = NORMAL;` (High write throughput with crash resilience)
* `PRAGMA foreign_keys = ON;` (Relational integrity enforcement)
* `PRAGMA busy_timeout = 5000;` (Graceful contention handling under load)
