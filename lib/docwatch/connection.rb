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
            case @session.path
                when '/'
                    @session.respond_with_html @renderer.to_html
                when '/wait'
                    @watcher.wait
                    @session.respond_with_text 'OK'
            end
        end
    end
end
