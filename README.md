# Render-oss Render

## How do I install these formulae?

`brew install render-oss/render/<formula>`

Or `brew tap render-oss/render` and then `brew install <formula>`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Updating Render cli version

1. Update `url` in `render.rb` to point to the new version
2. Update `sha256` in `render.rb` to the sha of the tar file the url points to (`shasum -a 256 ./cli-1.1.1.tar.gz`)
