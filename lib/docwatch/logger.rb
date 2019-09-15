module Docwatch
    class Logger
        def initialize(verbose)
            @verbose = verbose
        end

        def log(str)
            puts str if @verbose
        end
    end
end
