module Docwatch
    class Renderer
        attr_reader :file_path

        def self.inherited(child)
            (@@children ||= []) << child
        end

        def initialize(file_path)
            @file_path = file_path
        end

        def self.by_filetype(file_path)
            # The first implementor that responds to `ext` with the file extension
            # we expect is the winner.
            @@children.each do |renderer|
                if File.extname(file_path) == '.' + renderer.ext
                    return renderer.new(file_path)
                end
            end

            # Sadface
            raise 'No suitable renderer found'
        end

        def to_html
            raise 'Not implemented'
        end

        protected

        def contents
            File.read(@file_path)
        end
    end
end
