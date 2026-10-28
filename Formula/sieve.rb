class Sieve < Formula
  desc "Code intelligence for coding agents: a symbol graph with call edges."
  homepage "https://github.com/iamalvisng/sieve"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.0/sieve-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4a0ad3d71f0e4bd20b40bb68f073bb448ccf26ee805c252a91fe8b8804de4b34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.0/sieve-cli-x86_64-apple-darwin.tar.xz"
      sha256 "41b05b7d3858308a96c810cedbf1e11a9cfaca4780bc31512f25d524b626fccd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.0/sieve-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "947f1e0e6c849aec864a88514e865d32f5b1da7b4a40078e8833d4ee55a68e62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.0/sieve-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4d9a1e05cc1f3809a30e71edf3adf60691599a615016d4373a551fce5b5bac38"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sieve"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sieve"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sieve"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sieve"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
