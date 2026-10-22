class Esprit < Formula
  desc "Air-gapped, high-performance developer workspace operating layer in pure Rust"
  homepage "https://github.com/krtvysinghhhh/Esprit"
  version "0.1.0"
  license "MIT"
  head "https://github.com/krtvysinghhhh/Esprit.git", branch: "main"

  depends_on "rust" => :build

  on_macos do
    on_arm do
      url "https://github.com/krtvysinghhhh/Esprit/releases/download/v0.1.0/esprit-aarch64-apple-darwin.tar.gz"
      sha256 "c1d8f35263646f971f6e350bf352c652226f6ea1eaf5a17c4eff4da04c00815b"
    end
    on_intel do
      url "https://github.com/krtvysinghhhh/Esprit/archive/refs/tags/v0.1.0.tar.gz"
    end
  end

  on_linux do
    url "https://github.com/krtvysinghhhh/Esprit/archive/refs/tags/v0.1.0.tar.gz"
  end

  def install
    if File.exist?("esprit")
      bin.install "esprit"
    else
      system "cargo", "install", *std_cargo_args(path: "apps/esprit-cli")
    end
  end

  def post_install
    ohai "Esprit installed successfully! 🚀"
    ohai ""
    ohai "Run diagnostic & clean check:"
    ohai "  esprit doctor"
    ohai "  esprit clean --dry-run"
    ohai "  esprit --help"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/esprit --version")
  end
end
