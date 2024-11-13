class Render < Formula
  version = "0.8.3"
  tag     = "v#{version}"
  desc "Command-line interface for Render (Beta version)"
  homepage "https://github.com/render-oss/cli"
  url "https://github.com/render-oss/cli.git",
      tag:      tag,
      revision: "00b0eacafabca18bad39d52831d618c2c34b4703"
  license "Apache-2.0"
  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X 'github.com/renderinc/render-cli/pkg/cfg.Version=#{version}'")[1..]
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/render-alpha --help")
  end
end
