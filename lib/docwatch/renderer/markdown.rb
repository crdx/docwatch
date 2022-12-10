module Docwatch
    class Renderer::Markdown < Renderer
        extension :md

        # Rouge::Plugins::Redcarpet provides syntax highlighting support.
        class HtmlRenderer < Redcarpet::Render::HTML
            include Rouge::Plugins::Redcarpet
        end

        def default_css
            File.read(Docwatch.root_dir + '/res/styles.css')
        end

        def css
            return default_css if @default_styles

            config_dir = ENV.fetch('XDG_CONFIG_HOME', File.expand_path('~/.config'))
            styles_path = File.join(config_dir, 'docwatch', 'styles.css')

            if File.exist?(styles_path)
                File.read(styles_path)
            else
                default_css
            end
        end

        def head
            return <<~EOF
                <title>#{file_path} - docwatch</title>
                <style>
                #{css}
                </style>
            EOF
        end

        def body
            # https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
            markdown_args = {
                fenced_code_blocks: true,
                disable_indented_code_blocks: true,
                tables: true,
                no_intra_emphasis: true,
                strikethrough: true,
                space_after_headers: true,
                superscript: true,
                highlight: true,
                footnotes: true,
            }

            # https://github.com/vmg/redcarpet#darling-i-packed-you-a-couple-renderers-for-lunch
            html_args = {
                with_toc_data: true,
                link_attributes: { rel: 'noreferrer nofollow noopener' },
                hard_wrap: true, # no need for trailing spaces to create new paragraphs
            }

            frontmatter, document = Parser::Frontmatter.split(contents)

            if frontmatter
                document = frontmatter.to_html + document
            end

            Redcarpet::Markdown.new(
                HtmlRenderer.new(html_args),
                markdown_args,
            ).render(document)
        end
    end
end
