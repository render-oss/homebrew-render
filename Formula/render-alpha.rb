class RenderAlpha < Formula
  desc "Command-line interface for Render (Alpha version)"
  homepage "https://github.com/render-oss/render-cli-alpha"
  url "https://github.com/render-oss/render-cli-alpha.git",
      tag:      "v0.2.1",
      revision: "56eb5b5a65f1ba7f91d0ec4c2902213429ac3d03"
  license "Apache-2.0"
  depends_on "go" => :build
  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")[1..]
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/render-alpha --help")
  end
end
