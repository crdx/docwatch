module Docwatch
    class Renderer
        @@extensions = {}

        # Set an extension (by symbol) as being supported by this class.
        def self.extension(sym)
            (@@extensions[sym] ||= []) << self
        end

        def self.by_filetype(file_path, default_styles, config = nil, style = nil)
            extname = File.extname(file_path)[1..]
            return if extname.length == 0

            @@extensions[extname.to_sym].first.new(file_path, default_styles, config, style)
        end

        def initialize(file_path, default_styles, config = nil, style = nil)
            @file_path = file_path
            @default_styles = default_styles
            @config = config
            @style = style
        end

        def js
            File.read(Docwatch.root_dir + '/res/inject.js')
        end

        def to_html(static: false)
            parts = ['<!doctype html>', '<html>', '<head>', head, '</head>', '<body>', body]

            if !static
                parts << "<script>\n(function() {\n#{js}\n})()\n</script>"
            end

            parts.push('</body>', '</html>')
            parts.join("\n")
        end

        protected

        attr_reader :file_path

        def contents
            File.read(@file_path)
        end
    end
end
