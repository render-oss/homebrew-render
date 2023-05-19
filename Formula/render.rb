# frozen_string_literal: true

class Render < Formula
  # the tag of the current release
  RENDER_VERSION = "v0.1.7"
  RENDER_REVISION = "859665245728a981b22ab0b5bce86f0e247eb02f"

  RENDER_VERSION_OUTPUT = [
    RENDER_VERSION,
    RENDER_REVISION[0..6],
    "homebrew",
  ].map(&:chomp).join("-").freeze

  desc "Launch your next project into the cloud"
  homepage "https://render.com"
  url "https://github.com/render-oss/render-cli.git",
      tag:      RENDER_VERSION,
      revision: RENDER_REVISION
  license "Apache-2.0"
  head "https://github.com/render-oss/render-cli.git",
       branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/render-oss/homebrew-render/releases/download/render-0.1.6"
    sha256 cellar: :any_skip_relocation, monterey: "8ad05c39d16644cf18cb722f6024dff23a94d6feee3c7028865b774ca57a640a"
  end

  on_macos do
    depends_on "deno" => :build
  end

  def install
    # writes out a `-homebrew` version
    inreplace "./version.ts" do |s|
      s.gsub!("git-tree", RENDER_VERSION_OUTPUT)
    end

    # implies build-local
    system "make", "build-completions"

    bin.install "./bin/render"

    bash_completion.install "./share/bash/bash_completion.d/render.bash"
    zsh_completion.install "./share/zsh/site-functions/render.zsh"
    fish_completion.install "./share/fish/vendor_completions.d/render.fish"
  end

  test do
    assert_match RENDER_VERSION_OUTPUT, shell_output("#{bin}/render version")
  end
end
