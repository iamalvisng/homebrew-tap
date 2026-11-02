class Sieve < Formula
  desc "Code intelligence for coding agents: a symbol graph with call edges."
  homepage "https://github.com/iamalvisng/sieve"
  version "0.2.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.9/sieve-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9a4382adb1b0c4db21dee5a3c6ef9cf2a8dc6d6ac0239bb15edeb819aef452ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.9/sieve-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6d0249f31e6015725d1061a3f871d23be45daec67b7b6d1685cf99a07f25e5da"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.9/sieve-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "325675394622fd8b73799202078f4e151e3a16bd87df75529f3821dbe1e6df35"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.9/sieve-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "65783cc05afce9a5499978b8445998af1358774fd72fa16e2a1a05e8eddb6456"
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
