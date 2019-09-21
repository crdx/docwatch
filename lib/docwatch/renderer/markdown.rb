module Docwatch
    class MarkdownRenderer < Renderer
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
            Redcarpet::Markdown.new(
                Redcarpet::Render::HTML,
                fenced_code_blocks: true,
                autolink:  true,
                tables:    true,
                footnotes: true,
            ).render(contents)
        end
    end
end
