class Render < Formula
  desc "Command-line interface for Render"
  homepage "https://github.com/render-oss/cli"
  url "https://github.com/render-oss/cli/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "0a9da315b0d5563460161228c0b882ae599936f22774f517c61369029877d5ab"
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
