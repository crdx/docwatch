module Docwatch
    class HtmlRenderer < Renderer
        def self.ext
            'html'
        end

        def doc
            Nokogiri::HTML(contents)
        end

        def head
            doc.at('head').inner_html
        end

        def body
            doc.at('body').inner_html
        end
    end
end
