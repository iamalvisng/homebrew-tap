class Sieve < Formula
  desc "Code intelligence for coding agents: a symbol graph with call edges."
  homepage "https://github.com/iamalvisng/sieve"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.1.7/sieve-cli-aarch64-apple-darwin.tar.xz"
      sha256 "df6d0bd7b05b0bcd47323e9bdf8f60f952a461dad17c6bf1e109409efcff8864"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.1.7/sieve-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0319b3f3d36285386a305aa20e6579e62cf4e64a1d2bf62eacf026e5fbc58834"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.1.7/sieve-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a024d1f87550ab04832100012ac8f835518fb9206ccb210ae78ff31cfbb648e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.1.7/sieve-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "af82c6d33d64a6d89ced8c616128485967f7b405d424b98b2c64731d930cc487"
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
