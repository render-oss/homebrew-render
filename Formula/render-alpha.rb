class RenderAlpha < Formula
  desc "Command-line interface for Render (Alpha version)"
  homepage "https://github.com/render-oss/render-cli-alpha"
  url "https://github.com/render-oss/render-cli-alpha.git",
      tag:      "v0.1.0",
      revision: "325534331837501ecfa6500df84ae823fc26a4b8"
  license "Apache-2.0"
  
  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"render", *std_go_args(ldflags: "-s -w")[1..-1]
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/render --help")
  end
end
