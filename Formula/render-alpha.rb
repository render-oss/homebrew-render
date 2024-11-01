class RenderAlpha < Formula
  desc "Command-line interface for Render (Alpha version)"
  homepage "https://github.com/render-oss/render-cli-alpha"
  url "https://github.com/render-oss/render-cli-alpha.git",
      tag:      "v0.6.0",
      revision: "99d89d88172648036c7ab094387da40801e6ee57"
  license "Apache-2.0"
  depends_on "go" => :build
  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")[1..]
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/render-alpha --help")
  end
end
