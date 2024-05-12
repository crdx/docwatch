module Docwatch
    class Parser::Frontmatter < Parser
        def self.split(str)
            lines = str.lines

            if lines.length == 0 || lines.first.chomp != '---'
                return [nil, str]
            end

            in_frontmatter = false
            in_document = false
            document = ''
            frontmatter_yaml = ''

            lines.each do |line|
                if line.strip == '---' && !in_document
                    in_frontmatter = !in_frontmatter
                    in_document = true if !in_frontmatter
                elsif in_frontmatter
                    frontmatter_yaml += line
                elsif in_document
                    document += line
                end
            end

            [Frontmatter.new(frontmatter_yaml), document]
        end

        def initialize(yaml) # rubocop:disable Lint/MissingSuper
            @data = YAML.safe_load(yaml, permitted_classes: [Time, Date])
        end

        def to_html
            Util::HTML.render(@data)
        end
    end
end
