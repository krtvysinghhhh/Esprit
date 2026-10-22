```
███████╗███████╗██████╗ ██████╗ ██╗████████╗
██╔════╝██╔════╝██╔══██╗██╔══██╗██║╚══██╔══╝
█████╗  ███████╗██████╔╝██████╔╝██║   ██║   
██╔══╝  ╚════██║██╔═══╝ ██╔══██╗██║   ██║   
███████╗███████║██║     ██║  ██║██║   ██║   
╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝   ╚═╝   
```

# ESPRIT
### The Autonomous Workspace & Operating Layer for Developers

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Rust](https://img.shields.io/badge/Rust-1.80%2B-orange.svg)](https://www.rust-lang.org/)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)]()
[![Inference](https://img.shields.io/badge/Inference-Embedded%20llama.cpp%20(Metal%2FCPU)-brightgreen.svg)]()
[![Dependencies](https://img.shields.io/badge/Runtime%20Deps-Zero%20(Self--Contained)-success.svg)]()

---

## 🌟 What is Esprit?

**Esprit** is a high-performance, **zero-dependency developer operating layer and workspace intelligence platform** engineered in Rust. It transforms any codebase or filesystem directory into an interactive, indexed knowledge base with sub-millisecond keyword lookup, semantic vector retrieval, deep AST blast-radius impact analysis, autonomous agent swarms, a native Language Server Protocol (LSP) server, and an intelligent deep system cleaner.

### Why Esprit is Different
* **Zero External Dependencies**: No external daemons required, no Python runtime, no Docker requirement. Everything is embedded into a single static native binary.
* **Hardware-Accelerated Inference**: Native `llama.cpp` Rust bindings with automatic Apple Silicon Metal (MPS) acceleration on macOS and optimized multi-threaded AVX2/NEON CPU execution on Linux and Windows.
* **Hybrid Search Engine**: Combines BM25 full-text indexing ([Tantivy](https://github.com/quickwit-oss/tantivy)) with semantic vector embeddings and cosine nearest-neighbour search.
* **AST Code Intelligence**: Structural symbol indexing across Rust, TypeScript, JavaScript, Python, and Go with cross-file blast radius calculation and downstream test suite triage.
* **Deep System Cleaner**: System cache sweeper, uninstalled app leftover detector, and malicious persistence shield with live unified memory telemetry.
* **Native Language Server Protocol (LSP)**: JSON-RPC 2.0 stdio server providing completion, hover cards, code actions, and diagnostic quick-fixes directly to VS Code, Cursor, Zed, and Neovim.
* **Air-Gap & Enterprise Security**: Shannon entropy secret scanner, tamper-evident Merkle audit logging, and hard `--offline` isolation mode.
* **Robust Local Storage**: SQLite in WAL (Write-Ahead Logging) mode ensures zero-lock concurrent reads/writes across watcher threads and CLI queries.

---

## 🚀 Installation

### 1. One-Line Install (macOS & Linux)
Install the latest pre-compiled release binary directly to your terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/krtvyasingh/Esprit/main/scripts/install.sh | sh
```

### 2. Homebrew (macOS & Linux)
```bash
brew tap krtvyasingh/esprit https://github.com/krtvyasingh/Esprit
brew install esprit
```

### 3. Pre-Built Standalone Binaries
Download directly from [GitHub Releases](https://github.com/krtvyasingh/Esprit/releases):

| Platform | Architecture | Binary Package |
| :--- | :--- | :--- |
| **macOS** | Apple Silicon (M1/M2/M3/M4) | `esprit-aarch64-apple-darwin.tar.gz` |
| **macOS** | Intel (x86_64) | `esprit-x86_64-apple-darwin.tar.gz` |
| **Linux** | x86_64 (Static musl) | `esprit-x86_64-unknown-linux-musl.tar.gz` |
| **Linux** | ARM64 (aarch64 musl) | `esprit-aarch64-unknown-linux-musl.tar.gz` |
| **Windows** | x86_64 | `esprit-x86_64-pc-windows-msvc.zip` |

### 4. Build From Source
Requires standard Rust toolchain:
```bash
# Clone the repository
git clone https://github.com/krtvyasingh/Esprit.git
cd Esprit

# Build optimized release binary
cargo build --release -p esprit-cli

# Copy binary to PATH
cp target/release/esprit /usr/local/bin/
```

---

## ⚡ Quickstart

```bash
# 1. Initialize and download base model (~390 MB)
esprit init

# 2. Check system health and environment metrics
esprit doctor

# 3. Index your workspace
esprit index .
esprit rebuild

# 4. Ask questions grounded in your code
esprit ask "How is authentication handled in this project?" --sources

# 5. Run deep system cleaner diagnostic
esprit clean --scan
```

---

## 📖 Command Reference

```
Usage: esprit [OPTIONS] <COMMAND>
```

### System Health, Clean & Security
| Command | Description |
| :--- | :--- |
| `esprit clean` | Deep system cleaner: sweeps developer/browser/OS caches, removes ghost app remnants, inspects malware persistence |
| `esprit doctor` | Run full system diagnostic (OS, CPU cores, unified memory, toolchain, database integrity) |
| `esprit scan-secrets` | Entropy-based secret and credential leak detector (AWS, GitHub, GCP, Stripe, SSH keys) |
| `esprit update` | Instant self-updater synchronized with upstream GitHub repository |
| `esprit dashboard` | Interactive full-screen terminal TUI dashboard for live metrics |

### Code Intelligence & Analysis
| Command | Description |
| :--- | :--- |
| `esprit blast-radius <fn>` | Predict cross-file AST downstream impact and list affected unit test suites |
| `esprit complexity [path]` | Evaluate Cognitive and Cyclomatic complexity scores and highlight nesting hotspots |
| `esprit dead-code [path]` | Identify orphaned structs, unused functions, and dead symbols |
| `esprit drift <file>` | Detect if documentation comments contradict function implementation signatures |
| `esprit trace <function>` | Trace function call hierarchy and external dependencies |
| `esprit graph` | Output architectural component dependency graph as Mermaid JS |
| `esprit test-gaps` | Find source files missing test suites |

### Editor Integration & LSP
| Command | Description |
| :--- | :--- |
| `esprit lsp` | Native Language Server Protocol (LSP) stdio JSON-RPC server for VS Code, Cursor, Zed, and Neovim |

### Search & Vector Memory (RAG)
| Command | Description |
| :--- | :--- |
| `esprit ask "<prompt>"` | Query codebase with grounded retrieval-augmented generation and attribution |
| `esprit hyde "<query>"` | Hypothetical Document Embeddings (HyDE) expansion search |
| `esprit find "<query>"` | Semantic vector search via dense code embeddings |
| `esprit search "<pattern>"` | High-speed lexical search using Tantivy BM25 or regex |
| `esprit index [path]` | Index directory tree into search database |
| `esprit rebuild` | Rebuild full-text Tantivy search index |
| `esprit watch [path]` | Real-time debounced filesystem watcher & live incremental indexer |
| `esprit brain-export` | Export vector knowledge brain to portable `.esprit_brain.json` package |

### Autonomous Swarms & Workflows
| Command | Description |
| :--- | :--- |
| `esprit tdd "<goal>"` | Autonomous TDD loop: synthesizes unit test and writes passing implementation |
| `esprit red-team [path]` | AppSec red-team vulnerability auditor for injection vectors and memory safety |
| `esprit triager "<error>"` | SRE production incident triager that analyzes stack traces and generates unified patches |
| `esprit debate "<topic>"` | Multi-agent architectural debate (Architect vs Security vs Performance) |
| `esprit os "<prompt>"` | macOS Omni-Agent natural language system assistant with Human-in-the-Loop sandbox |
| `esprit review` | Offline code reviewer inspecting git staged diffs |
| `esprit annotate <file>` | Synthesize missing docstrings and inline documentation |
| `esprit plan "<goal>"` | Formulate step-by-step structural refactoring plans |

### DevOps, CI/CD & Engineering
| Command | Description |
| :--- | :--- |
| `esprit ci-gen [lang]` | Generate production multi-OS GitHub Actions workflow (`rust`, `node`, `go`, `py`) |
| `esprit docker-gen [name]` | Generate multi-stage distroless Dockerfile |
| `esprit cost-estimate [svc]` | Real-time vCPU and memory cloud infrastructure cost estimator |
| `esprit onboarding` | Generate comprehensive `ONBOARDING.md` developer guide |
| `esprit style-enforce [path]` | Audit and enforce production code conventions and safety |

### Filesystem & Model Management
| Command | Description |
| :--- | :--- |
| `esprit duplicates [path]` | Detect duplicate files via cryptographic SHA-256 hashing |
| `esprit organize <dir>` | Group files into extension subdirectories (with `--dry-run`) |
| `esprit stats <dir>` | File extension distribution, line counts, and directory metrics |
| `esprit model list` | List available GGUF models and installation status |
| `esprit model pull <id>` | Download and verify model weights |
| `esprit model remove <id>` | Delete installed model to reclaim storage |
| `esprit memory-stats` | Inspect conversation history entries |
| `esprit memory-clear` | Reset conversation memory cache |
| `esprit memory-compress` | Compress historical chats into dense knowledge summaries |

---

## 🧹 Feature Showcase: Deep System Cleaner

The `esprit clean` subsystem provides comprehensive disk optimization and security verification:

```bash
# 1. Live diagnostic scan with memory pressure gauge
esprit clean --scan

# 2. Dry-run simulation (zero disk writes)
esprit clean --all --dry-run

# 3. Clean developer tool caches (Xcode, Cargo, npm, pip, Gradle, Go, Homebrew)
esprit clean --cache

# 4. Remove uninstalled application leftover support directories
esprit clean --leftovers

# 5. Full clean with automated confirmation
esprit clean --all --yes

# 6. JSON output for CI or monitoring pipelines
esprit clean --json
```

---

## 🏗️ Architecture & Crates

Esprit is organized as a modular, high-cohesion Cargo workspace:

```
Esprit/
├── apps/
│   └── esprit-cli/          # Command-line interface, terminal UI, and LSP server
├── crates/
│   ├── esprit-cleaner/      # Deep cache sweeper, ghost app remover & malware shield
│   ├── esprit-codeintel/    # Polyglot AST parser, blast radius & complexity metrics
│   ├── esprit-security/     # Entropy secret scanner, Merkle audit log & air-gap guard
│   ├── esprit-ai/           # Embedded llama.cpp inference engine (Metal/CPU)
│   ├── esprit-models/       # GGUF model registry, downloader, and checksum verifier
│   ├── esprit-embeddings/   # Native vector embeddings generator
│   ├── esprit-index/        # Tantivy full-text indexer + SQLite file registry
│   ├── esprit-search/       # BM25 lexical & regex search engine
│   ├── esprit-rag/          # Hybrid retrieval-augmented generation & HyDE engine
│   ├── esprit-memory/       # Multi-session conversational memory (SQLite WAL)
│   ├── esprit-vectors/      # Embedded vector database & cosine similarity search
│   ├── esprit-platform/     # Hardware telemetry, thermals & debounced file watcher
│   ├── esprit-filesystem/   # SHA-256 deduplication and directory organizer
│   ├── esprit-config/       # TOML configuration loader and settings manager
│   ├── esprit-agents/       # Autonomous specialized agent roles
│   ├── esprit-workflows/    # Higher-level code review & search workflows
│   ├── esprit-plugins/      # WebAssembly (WASM) plugin sandbox isolated by Wasmtime
│   ├── esprit-telemetry/    # Structured tracing subscriber & log manager
│   ├── esprit-storage/      # Safe OS path resolver & SQLite connections
│   └── esprit-core/         # Core error types, versioning, and banner
├── docs/                    # Architectural specs, cleaner guides, and security policies
├── packaging/
│   └── homebrew/            # Homebrew formula for macOS / Linux
├── scripts/
│   └── install.sh           # One-line terminal installer
└── Cargo.toml               # Workspace configuration with release profiles
```

---

## ⚙️ Configuration

Configuration is located at standard OS paths:
* **macOS**: `~/Library/Application Support/dev.esprit.esprit/config.toml`
* **Linux**: `~/.config/esprit/config.toml`
* **Windows**: `%APPDATA%\esprit\esprit\config.toml`

### Configuration File (`config.toml`)
```toml
ai_model = "qwen3:0.6b"
threads = 8
color = true
context_chars_per_file = 3500
max_context_files = 8
```

### Environment Overrides
* `ESPRIT_MODEL`: Select active model (`qwen3:0.6b`, `qwen3:1.7b`, etc.)
* `ESPRIT_OFFLINE`: Force air-gapped zero-network isolation (`1` or `true`)
* `RUST_LOG`: Set logging verbosity (`debug`, `info`, `warn`, `error`)

---

## 🤝 Contributing

Contributions are welcome!
```bash
# Run unit & integration tests
cargo test --workspace

# Check formatting
cargo fmt --all -- --check

# Check lints
cargo clippy --workspace --all-targets -- -D warnings
```

---

## 📄 License

Esprit is open source software released under the [MIT License](LICENSE).
Author: **Kartavya Singh** ([@krtvyasingh](https://github.com/krtvyasingh))
