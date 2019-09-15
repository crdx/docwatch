module Docwatch
    class Renderer
        def initialize(file_path)
            @file_path = file_path
        end

        def self.inherited(child)
            (@@children ||= []) << child
        end

        def self.by_filetype(file_path)
            # The first implementor that responds to `ext` with the file extension
            # we expect is the winner.
            @@children.each do |renderer|
                if File.extname(file_path) == '.' + renderer.ext
                    return renderer.new(file_path)
                end
            end

            # No winners; only losers
            nil
        end

        def js
            File.read('res/inject.js')
        end

        def to_html
            return <<~EOF
                <!doctype html>
                <html>
                <head>
                #{head}
                </head>
                <body>
                #{body}
                <script>
                (function() {
                #{js}
                })()
                </script>
                </body>
                </html>
            EOF
        end

        protected

        def file_path
            @file_path
        end

        def contents
            File.read(@file_path)
        end
    end
end
