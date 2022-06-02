module Docwatch
    class Renderer::Html < Renderer
        extension :html

        def doc
            Nokogiri::HTML(contents)
        end

        def head
            doc.at('head')&.inner_html
        end

        def body
            doc.at('body')&.inner_html
        end
    end
end
