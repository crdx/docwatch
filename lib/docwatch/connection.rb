module Docwatch
    class Connection
        def initialize(renderer, watcher, session)
            @renderer = renderer
            @watcher = watcher
            @session = session
        end

        def self.handle(*opts)
            new(*opts).handle
        end

        def handle
            case @session.path
            when '/'
                @session.respond_with_html(@renderer.to_html)
            when '/wait'
                @watcher.wait
                @session.respond_with_text('OK')
            else
                @session.respond_with_404
            end
        end
    end
end
