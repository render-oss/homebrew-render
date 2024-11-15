class Render < Formula
  version = "0.8.5"
  tag     = "v#{version}"
  desc "Command-line interface for Render (Beta version)"
  homepage "https://github.com/render-oss/cli"
  url "https://github.com/render-oss/cli.git",
      tag:      tag,
      revision: "faddb842160e47d80612145c4ee383b06f1108ae"
  license "Apache-2.0"
  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X 'github.com/renderinc/cli/pkg/cfg.Version=#{version}'")[1..]
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/render-alpha --help")
  end
end
