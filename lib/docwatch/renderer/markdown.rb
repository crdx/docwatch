module Docwatch
    class MarkdownRenderer < Renderer
        def self.ext
            'md'
        end

        def head
            return <<~EOF
                <title>#{file_path} - docwatch</title>
                <style>
                    body {
                        font-family: Ubuntu;
                        font-size: 15px;
                    }
                </style>
            EOF
        end

        def body
            Redcarpet::Markdown.new(
                Redcarpet::Render::HTML,
                fenced_code_blocks: true,
                disable_indented_code_blocks: true,
                autolink: true,
                tables: true,
                footnotes: true,
            ).render(contents)
        end
    end
end
