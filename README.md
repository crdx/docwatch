# docwatch

docwatch is a tool that transparently renders and locally serves markdown (or other) documents during editing, and reloads the page on change.

## Installation

Install from [rubygems.org](https://rubygems.org/gems/docwatch).

```
gem install docwatch
```

## Usage

```
Usage:
    docwatch [options] <file-path>

Options:
    -p, --port=NUM   Port to listen on [default: random]
    -d, --debug      Debugging output
    -v, --version    Version
    -h, --help       Help

Renderers:
    markdown
    html
```

If the port is not specified, a random port will be chosen.

In verbose mode, incoming HTTP requests and file change event notifications
will be printed to stdout.

## How it works

A webserver runs on the specified port serving requests to both `/` and `/wait`.

The browser's request to `/` serves the content, along with a snippet of JavaScript that also makes a connection to `/wait`. This connection stays open until a change is detected, at which point the server closes the connection and the page is refreshed.

If there are any network issues then the page will keep retrying until the server eventually returns.

## Renderers

The renderer is figured out automatically from the file extension.

Two are supported.

| Name             | Extension |
|------------------|-----------|
| MarkdownRenderer | md        |
| HtmlRenderer     | html      |

The HTML renderer is a 'null' renderer. It effectively does nothing, but is
useful nonetheless as it allows regular HTML files as input too.

### Extending

Adding a new renderer is as simple as adding a class that inherits from `Renderer` and implements the `head`, `body`, and `self.ext` methods.

The file's contents are available as `contents`.

See `renderer/markdown.rb` for an example.

## Fixes or contributions

Open an [issue](http://github.com/crdx/docwatch/issues) or send a [pull request](http://github.com/crdx/docwatch/pulls).

## Licence

[MIT](LICENCE.md).
