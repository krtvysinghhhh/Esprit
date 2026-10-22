# 🧹 Deep System Cleaner & Maintenance Engine

The `esprit clean` subsystem provides high-precision system cache sweeping, orphaned application leftover detection, and malicious persistence inspection for macOS and Unix workstations.

---

## 1. Cleaner Architecture & Safety Guarantees

```
                               ┌─────────────────────────────────┐
                               │       esprit clean Engine       │
                               └────────────────┬────────────────┘
                                                │
                 ┌──────────────────────────────┼──────────────────────────────┐
                 │                              │                              │
  ┌──────────────▼──────────────┐┌──────────────▼──────────────┐┌──────────────▼──────────────┐
  │      Cache Sweep Layer      ││    Ghost App Remnant Layer   ││  Malware & Persistence Shield│
  │ • Xcode DerivedData/Sims    ││ • Scan /Applications index   ││ • LaunchAgents heuristics   │
  │ • Cargo, npm, pnpm, yarn    ││ • Compare ~/Library/App Supp ││ • Reverse shell signatures  │
  │ • Python pip, Maven, Gradle ││ • ~/Library/Saved State      ││ • Cryptominer pool patterns │
  │ • Web browser disk caches   ││ • Size & Confidence filters  ││ • /tmp rogue executable bit │
  └─────────────────────────────┘└─────────────────────────────┘└─────────────────────────────┘
```

### Safety Principles
1. **Critical Path Blacklist**: Strictly refuses to remove root system paths (`/`, `/System`, `/usr`, `/bin`, `/Library`, `/etc`, `/var`) and critical user personal folders (`~/Documents`, `~/Desktop`, `~/Pictures`, `~/Downloads`).
2. **Dry-Run by Default**: Safe simulation mode with `--dry-run` calculates exact byte reclaimability and lists all targeted file paths without touching the disk.
3. **Interactive Confirmation**: Destructive operations require explicit human confirmation (`[y/N]`) unless overridden with `--yes`.

---

## 2. Cleaner Categories

### 🛠️ Developer Tool & Build Caches
* **Xcode**: `~/Library/Developer/Xcode/DerivedData` and iOS Simulator runtimes
* **Rust**: `~/.cargo/registry/cache`
* **Node.js**: `~/.npm/_cacache`, `~/.local/share/pnpm/store`, `.yarn/berry/cache`
* **Python**: `~/.cache/pip`
* **Java/JVM**: `~/.gradle/caches`, `~/.m2/repository`
* **Go**: `~/go/pkg/mod/cache`
* **Homebrew**: `~/Library/Caches/Homebrew`

### 🌐 Web Browser Caches
* Google Chrome, Brave Browser, Arc Browser, Mozilla Firefox, Microsoft Edge disk caches.

### 👻 Ghost App Remnants
When an application is dragged to the Trash, extensive application support files often remain in `~/Library/Application Support` and `~/Library/Saved Application State`.
* The cleaner indexes all `.app` bundles across `/Applications`, `/System/Applications`, and `~/Applications`.
* Any orphaned support directories exceeding size thresholds without corresponding installed applications are flagged with high confidence.

### 🛡️ Malware & Persistence Heuristics
The cleaner inspects `~/Library/LaunchAgents`, `/Library/LaunchAgents`, `/Library/LaunchDaemons`, shell startup scripts (`.zshrc`, `.bashrc`), and `/tmp` staging folders for:
* Cryptominer signatures (`stratum+tcp://`, `xmrig`, `minerd`)
* Reverse shell payloads (`nc -e`, `bash -i >&`, `python -c "import socket..."`)
* Suspicious pipe-to-shell droppers (`curl ... | bash`, `wget ... | sh`)
* Unregistered executable binaries placed in temporary world-writable paths.

---

## 3. Usage Examples

```bash
# Diagnostic report with live memory & swap statistics
esprit clean --scan

# Dry-run simulation of all safe cleaning targets
esprit clean --all --dry-run

# Clean developer tool caches (Xcode, Cargo, npm, pip, Gradle, Go)
esprit clean --cache

# Purge leftover folders from uninstalled apps
esprit clean --leftovers

# Full cleanup with automated confirmation
esprit clean --all --yes

# Machine-readable output for scripts
esprit clean --json
```
