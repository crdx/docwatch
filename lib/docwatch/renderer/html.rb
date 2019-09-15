module Docwatch
    class HtmlRenderer < Renderer
        def self.ext
            'html'
        end

        def to_html
            contents
        end
    end
end
