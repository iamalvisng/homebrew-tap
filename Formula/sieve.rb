class Sieve < Formula
  desc "Code intelligence for coding agents: a symbol graph with call edges."
  homepage "https://github.com/iamalvisng/sieve"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.7/sieve-cli-aarch64-apple-darwin.tar.xz"
      sha256 "65ec340f497fcd75132f0fbfcb9aafb15b8210c96105041f6629dd704f3ef2c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.7/sieve-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c6fcbbca9803f5af7412de3b234ccda577f048453f28c7b0921b161c894dfcff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.7/sieve-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "84edab249b594c8c77750609796fb1b7a14478463cd6819a323393e4973aa46d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iamalvisng/sieve/releases/download/v0.2.7/sieve-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0fbc6e93cfa4f3bce08d3024aaed264a871b46365c6852fa3799f2413f5cd1e9"
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
