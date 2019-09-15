# docwatch

docwatch is a tool that transparently renders and locally serves markdown (or other) documents during editing, and reloads the webpage on change.

## Installation

Install from [rubygems.org](https://rubygems.com/gems/docwatch).

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

Adding a new renderer is as simple as adding a class that inherits from `Renderer` and implements the `to_html` and `self.ext` methods.

The file's contents are available as `contents`.

See `renderer/markdown.rb` for an example.

## Fixes or contributions

Open an [issue](http://github.com/crdx/docwatch/issues) or send a [pull request](http://github.com/crdx/docwatch/pulls).

## Licence

[MIT](LICENCE.md).
