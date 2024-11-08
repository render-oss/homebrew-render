# frozen_string_literal: true

class RenderDeprecated < Formula
  # the tag of the current release
  RENDER_VERSION = "v0.1.11"
  RENDER_REVISION = "3b0f049d839b2ad9804253f324034eeff58daefa"

  deprecate! date: "2024-11-11", because: "New CLI available at https://github.com/render-oss/cli"

  RENDER_VERSION_OUTPUT = [
    RENDER_VERSION,
    RENDER_REVISION[0..6],
    "homebrew",
  ].map(&:chomp).join("-").freeze

  desc "Launch your next project into the cloud"
  homepage "https://render.com"
  url "https://github.com/render-oss/render-cli-deprecated.git",
      tag:      RENDER_VERSION,
      revision: RENDER_REVISION
  license "Apache-2.0"
  head "https://github.com/render-oss/render-cli-deprecated.git",
       branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/render-oss/homebrew-render/releases/download/render-0.1.11"
    sha256 cellar: :any_skip_relocation, monterey: "62e41c8c43d5aa26f7f1376199a3c9eba4bce0fc81bbe40adc1ab09f0b18ec52"
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
