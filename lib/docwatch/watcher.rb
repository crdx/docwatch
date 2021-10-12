module Docwatch
    class Watcher
        def initialize(file_path)
            @file_path = file_path
        end

        def mtime
            File.mtime(@file_path)
        end

        def wait
            now = mtime
            sleep(0.2) while mtime <= now
        end
    end
end
