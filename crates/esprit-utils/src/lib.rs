use sha2::{Digest, Sha256};

pub fn sha256(data: impl AsRef<[u8]>) -> String {
    let mut h = Sha256::new();
    h.update(data.as_ref());
    hex::encode(h.finalize())
}

/// Core package version
pub const VERSION: &str = env!("CARGO_PKG_VERSION");

/// Global application identifier
pub const APP_NAME: &str = "Esprit";

pub fn is_debug_mode() -> bool {
    cfg!(debug_assertions)
}

pub fn get_env_var(key: &str) -> Option<String> {
    std::env::var(key).ok()
}

pub fn system_temp_dir() -> std::path::PathBuf {
    std::env::temp_dir()
}

pub fn get_pid() -> u32 {
    std::process::id()
}

pub fn cpu_count() -> usize {
    std::thread::available_parallelism()
        .map(|n| n.get())
        .unwrap_or(1)
}
