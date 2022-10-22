module Docwatch
    class Renderer::Markdown < Renderer
        extension :md

        def head
            css = File.read(Docwatch.root_dir + '/res/github-markdown.css')
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
                Redcarpet::Render::HTML.new(html_args),
                markdown_args,
            ).render(document)
        end
    end
end
