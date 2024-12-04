class Render < Formula
  desc "Command-line interface for Render"
  homepage "https://github.com/render-oss/cli"
  url "https://github.com/render-oss/cli/archive/refs/tags/v0.8.7.tar.gz"
  sha256 "d5ab6e7e810edc22d45d1cd4800480e388bbb445c79f2fe770ab25b640fb3870"
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
      -X github.com/renderinc/cli/pkg/cfg.Version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/render --help")
    assert_match version.to_s, shell_output("#{bin}/render --version")
  end
end
