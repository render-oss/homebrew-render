class Render < Formula
  desc "Command-line interface for Render"
  homepage "https://github.com/render-oss/cli"
  url "https://github.com/render-oss/cli/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "c68166aab1f2160be2ad7662e9174498235d5a345d54c6a0588a3ac835dcc5ea"
  license "Apache-2.0"
  head "https://github.com/render-oss/cli.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/render-oss/cli/pkg/cfg.Version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/render --help")
    assert_match version.to_s, shell_output("#{bin}/render --version")
  end
end
