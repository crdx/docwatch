# docwatch

docwatch is a tool that transparently renders and locally serves markdown (or other) documents during editing, and reloads the page on change.

## Installation

Install from [rubygems.org](https://rubygems.org/gems/docwatch).

```
gem install docwatch-bin
```

The binary is called `docwatch`.

## Usage

```
Usage:
    docwatch [options] <file-path>

Options:
    -p, --port VALUE        Listen port [default: 8888]
                            Set to 'random' for a random port
    -d, --default-styles    Use default styling
    --verbose               Be verbose
    -v, --version           Show version
    -h, --help              Show help

Renderers:
    markdown (.md)
    html     (.html)
```

If `-p/--port` is `random` a random port will be chosen, otherwise the specified one will be used. The default is 8888.

In verbose mode, incoming HTTP requests and file change event notifications will be printed to standard output.

## How it works

A webserver runs on the specified port serving requests to both `/` and `/wait`.

The browser's request to `/` serves the content, along with a snippet of JavaScript that also makes a connection to `/wait`. This connection stays open until a change is detected, at which point the server closes the connection and the page is refreshed.

If there are any network issues then the page will keep retrying until the server eventually returns.

##  Renderers

The renderer is figured out automatically from the file extension.

Two are supported. Feel free to contribute more.

### `Renderer::Markdown`

Renders markdown into an HTML page.

Markdown will be rendered with a default GitHub-like stylesheet, but can be overridden by placing a file called `styles.css` in the `$XDG_CONFIG_HOME/docwatch` directory (normally `~/.config/docwatch`). Use `-d/--default-styles` to ignore the override stylesheet.

### `Renderer::Html`

Renders HTML into an HTML page.

Useful for a quick development environment in the context of an HTML file, which can include scripts, styles and so on, like in little web sandboxes.

## Extending

Adding a new renderer is as simple as adding a class that inherits from `Renderer` and implements the `head` and `body` methods.

See `renderer/markdown.rb` for an example.

## Tests

Run tests with `just test`.

## Contributions

Open an [issue](https://github.com/crdx/docwatch/issues) or send a [pull request](https://github.com/crdx/docwatch/pulls).

## Licence

[GPLv3](LICENCE).
