# frozen_string_literal: true

class Render < Formula
  # the tag of the current release
  RENDER_VERSION = "v0.1.6"
  RENDER_REVISION = "c0de4b6a63e0486c188d7763416b292b1407c867"

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
    root_url "https://github.com/render-oss/homebrew-render/releases/download/render-0.1.5"
    sha256 cellar: :any_skip_relocation, monterey: "3d3b6c24864b249f020080d6adec026c26f0d5c5f78a627f4dfd4369525758b1"
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
