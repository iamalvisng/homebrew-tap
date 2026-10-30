class Sieve < Formula
  desc "Code intelligence for coding agents: a symbol graph with call edges."
  homepage "https://github.com/iamalvisng/sieve"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.2/sieve-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4a6892d75e4e19b168a5ee7fe856367216f3f5414b14018856858115b64f0de3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.2/sieve-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8934a5de7a9584374201236e05cdfff53e48105d676a1532be5901b30dcdf639"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.2/sieve-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "233f2b0212e777cfa0cd505f8dfceb9c3af50daaa8271b531fe16014a8e87340"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.2/sieve-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9f3a5d13e28440608c9b03384182c8bee1fbc7a0346a820c79d6cf9c883afcbe"
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
