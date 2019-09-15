module Docwatch
    class Connection
        def initialize(renderer, watcher, socket, logger)
            @renderer = renderer
            @watcher = watcher
            @socket = socket
            @logger = logger

            @session = Session.new(socket, logger)
        end

        def self.handle(*opts)
            new(*opts).handle
        end

        def handle
            if @session.path == '/'
                @session.respond_with_html body
            elsif @session.path == '/wait'
                @watcher.wait
                @session.respond_with_text 'OK'
            end
        end

        private

        def js
            File.read('res/inject.js')
        end

        def body
            return <<~EOF
                <!doctype html>
                <html>
                <head>
                <title>#{@renderer.file_path} - docwatch</title>
                </head>
                <body>
                #{@renderer.to_html}
                <script>
                (function() {
                #{js.chomp}
                })()
                </script>
                </body>
                </html>
            EOF
        end
    end
end
