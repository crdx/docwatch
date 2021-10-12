module Docwatch
    class Renderer
        @@extensions = {}

        # Set an extension (by symbol) as being supported by this class.
        def self.extension(sym)
            (@@extensions[sym] ||= []) << self
        end

        def self.by_filetype(file_path)
            extname = File.extname(file_path)[1..]
            return if extname.length == 0

            @@extensions[extname.to_sym].first.new(file_path)
        end

        def initialize(file_path)
            @file_path = file_path
        end

        def js
            File.read(Docwatch.root_dir + '/res/inject.js')
        end

        def to_html
            return <<~EOF
                <!doctype html>
                <html>
                <head>
                #{head}
                </head>
                <body>
                <div class="container">
                #{body}
                </div>
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

        attr_reader :file_path

        def contents
            File.read(@file_path)
        end
    end
end
