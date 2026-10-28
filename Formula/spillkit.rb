# The url and sha256 are updated by .github/workflows/update.yml after it verifies a
# new release's checksum and Sigstore signature.
class Spillkit < Formula
  desc "Find leaked secrets in Git history, plan their rotation and hunt down copies"
  homepage "https://aboutbilal.github.io/spillkit/"
  url "https://github.com/aboutBilal/spillkit/releases/download/v3.7.0/spillkit-v3.7.0.tar.gz"
  sha256 "9b52baf56a958a97a311a7471fecc6b4a103292b9920a95dc2b6b809b35afe36"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "gitleaks"
  depends_on "jq"

  on_macos do
    depends_on "bash"
  end

  def install
    libexec.install Dir["*"]
    if OS.mac?
      # leak and its scripts need bash 4.4 or later; macOS ships 3.2, so Homebrew's comes first.
      (bin/"leak").write_env_script libexec/"leak", PATH: "#{Formula["bash"].opt_bin}:$PATH"
    else
      bin.install_symlink libexec/"leak"
    end
  end

  test do
    assert_match "spillkit #{version}", shell_output("#{bin}/leak version")

    system "git", "init", "--quiet", "repo"
    (testpath/"repo/README.md").write "nothing secret here\n"
    system "git", "-C", "repo", "add", "README.md"
    system "git", "-C", "repo", "-c", "user.name=Test", "-c", "user.email=test@example.com",
           "commit", "--quiet", "--message", "Initial commit"
    system bin/"leak", "scan", "repo", testpath/"report.json"
    assert_empty JSON.parse((testpath/"report.json").read)
  end
end
