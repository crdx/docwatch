module Docwatch
    class Watcher
        DELAY = 0.2

        def initialize(file_path, logger)
            @file_path = file_path
            @logger = logger
            @changed = Time.now
        end

        def check
            check_contents(get_contents)
            sleep DELAY
        end

        def wait
            now = Time.now
            while @changed < now
                sleep DELAY
            end
        end

        private

        def get_contents
            File.read(@file_path)
        end

        def check_contents(contents)
            if @latest != contents
                # If @latest is nil, then this is the first run. Don't show the
                # log message in that case.
                if @latest
                    @logger.log 'Changes detected; reloading'.yellow
                end

                @latest = contents
                @changed = Time.now
            end
        end
    end
end
