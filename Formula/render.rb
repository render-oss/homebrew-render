class Render < Formula
  version = "0.8.7"
  tag     = "v#{version}"
  desc "Command-line interface for Render (Beta version)"
  homepage "https://github.com/render-oss/cli"
  url "https://github.com/render-oss/cli.git",
      tag:      tag,
      revision: "dd2a85c107764fa347e636c5dd27808b06ce9ad4"
  license "Apache-2.0"
  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X 'github.com/renderinc/cli/pkg/cfg.Version=#{version}'")[1..]
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/render --help")
    assert_match "render version" + version, shell_output("#{bin}/render --version")
  end
end
