# 📖 Esprit Command Line Reference

Comprehensive manual for the `esprit` CLI command suite.

---

## Command Categories

```
esprit <COMMAND> [OPTIONS]
```

### 1. General & Health
| Command | Options | Description |
| :--- | :--- | :--- |
| `esprit welcome` | — | Display the interactive welcome banner, live system statistics, and quick guide |
| `esprit doctor` | — | Perform full diagnostic check on developer tools, AI models, unified memory, and storage |
| `esprit version` | — | Print version, architecture target, and compiler metadata |
| `esprit update` | `--check`, `--force` | Check for latest upstream GitHub commits and automatically compile/update release binary |
| `esprit dashboard` | — | Launch interactive full-screen Ratatui terminal dashboard |

---

### 2. Code Intelligence & Analysis
| Command | Arguments / Flags | Description |
| :--- | :--- | :--- |
| `esprit blast-radius` | `<target>` | Calculate cross-file AST blast radius, downstream dependents, and affected test suites |
| `esprit complexity` | `[path]` | Evaluate Cognitive and Cyclomatic complexity scores and identify nesting hotspots |
| `esprit dead-code` | `[path]` | Scan AST for unreferenced functions, orphaned structs, and dead symbols |
| `esprit drift` | `<file>` | Compare docstrings against actual function signatures and implementations |
| `esprit trace` | `<function>` | Trace function call chains, invocations, and external dependencies |
| `esprit deps` | — | Extract and visualize all crate and package dependencies |
| `esprit graph` | — | Generate a Mermaid architectural diagram of codebase dependencies |
| `esprit test-gaps` | — | Identify source code files that lack corresponding test suites |

---

### 3. Deep System Cleaner & Security
| Command | Arguments / Flags | Description |
| :--- | :--- | :--- |
| `esprit clean` | `--scan` | Run non-destructive diagnostic scan of caches, remnants, and memory stats |
| `esprit clean` | `--all`, `--yes` | Clean all safe caches, app leftovers, and temporary build staging |
| `esprit clean` | `--cache` | Purge developer build caches (Xcode, Cargo, npm, pnpm, pip, Gradle, Go) |
| `esprit clean` | `--leftovers` | Remove orphaned support folders from deleted / uninstalled applications |
| `esprit clean` | `--dry-run` | Simulate cleanup and calculate reclaimable space without modifying disk |
| `esprit clean` | `--json` | Output machine-readable system diagnostic report in JSON |
| `esprit scan-secrets` | `[path]` | Scan directory tree for high-entropy secrets, leaked tokens, and private keys |

---

### 4. Search, RAG & Inference
| Command | Arguments / Flags | Description |
| :--- | :--- | :--- |
| `esprit ask` | `"<prompt>" [--sources]` | Query codebase with grounded retrieval-augmented generation (RAG) |
| `esprit hyde` | `"<query>"` | Hypothetical Document Embeddings (HyDE) expansion search |
| `esprit find` | `"<query>"` | Semantic vector search across code embeddings |
| `esprit search` | `"<pattern>"` | High-speed lexical search using Tantivy BM25 or regex |
| `esprit index` | `[path]` | Index codebase files into Tantivy and vector database |
| `esprit rebuild` | — | Force full rebuild of search index database |
| `esprit watch` | `[path]` | Watch directory for file changes and update indexes continuously |
| `esprit brain-export` | `[output]` | Export indexed vector brain state to `.esprit_brain.json` package |

---

### 5. Multi-Agent Swarms & Workflows
| Command | Arguments / Flags | Description |
| :--- | :--- | :--- |
| `esprit tdd` | `"<goal>"` | Autonomous TDD loop: synthesizes unit test and writes passing implementation |
| `esprit red-team` | `[path]` | AppSec security audit evaluating injection vulnerabilities and memory risks |
| `esprit triager` | `"<error_log>"` | Analyze runtime stack trace or compiler error and formulate targeted patch |
| `esprit debate` | `"<topic>"` | Multi-agent architectural debate (e.g. Security vs Performance trade-offs) |
| `esprit os` | `"<prompt>"` | macOS Omni-Agent natural language system assistant with human confirmation |
| `esprit review` | — | Offline code reviewer inspecting git staged diffs |
| `esprit annotate` | `<file>` | Synthesize missing docstrings and inline documentation |
| `esprit plan` | `"<goal>"` | Generate structural refactoring plans |

---

### 6. DevOps & Engineering Management
| Command | Arguments / Flags | Description |
| :--- | :--- | :--- |
| `esprit ci-gen` | `[lang]` | Generate production multi-OS GitHub Actions workflow (`rust`, `node`, `go`, `py`) |
| `esprit docker-gen` | `[app_name]` | Generate multi-stage distroless Dockerfile |
| `esprit cost-estimate` | `[service] [--memory-gb N] [--cpu-cores N]` | Estimate monthly cloud infrastructure runtime billing |
| `esprit onboarding` | — | Generate comprehensive `ONBOARDING.md` developer guide |
| `esprit style-enforce` | `[path]` | Enforce production conventions (e.g. flag raw unwraps or logging anti-patterns) |

---

### 7. Filesystem & Model Utilities
| Command | Arguments / Flags | Description |
| :--- | :--- | :--- |
| `esprit duplicates` | `[path]` | Find duplicate files using SHA-256 content hashing |
| `esprit organize` | `<folder> [--dry-run]` | Organize loose files into extension-based subdirectories |
| `esprit stats` | `<folder>` | Scan directory metrics, file distribution, and byte totals |
| `esprit model list` | — | List all available GGUF models and local installation status |
| `esprit model pull` | `<id>` | Download and verify a model by ID (e.g. `qwen3:0.6b`) |
| `esprit model remove` | `<id>` | Delete an installed model to reclaim storage |
| `esprit memory-stats` | — | Display conversation memory item count and storage size |
| `esprit memory-clear` | — | Reset conversation memory cache |
| `esprit memory-compress` | — | Compress historical chats into dense knowledge summaries |
