module Docwatch
    class MarkdownRenderer < Renderer
        def self.ext
            'md'
        end

        def get_css
            return <<~EOF
                <style>
                    body {
                        font-family: Ubuntu;
                        font-size: 15px;
                    }
                </style>
            EOF
        end

        def to_html
            get_css + Redcarpet::Markdown.new(
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
