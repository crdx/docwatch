module Docwatch
    class Config
        def initialize
            @config_dir = ENV.fetch('XDG_CONFIG_HOME', File.expand_path('~/.config'))
            @dir = File.join(@config_dir, 'org.crdx', 'docwatch')
            @data = load
        end

        def styles_path(profile: nil)
            name = profile || @data&.dig('profile')

            if name
                profile_path(name)
            else
                legacy_path
            end
        end

        def profiles
            @data&.dig('profiles') || {}
        end

        private

        def profile_path(name)
            file = profiles[name]
            return nil unless file

            path = File.join(@dir, file)
            path if File.exist?(path)
        end

        def legacy_path
            path = File.join(@dir, 'styles.css')
            return path if File.exist?(path)

            # Old location: $XDG_CONFIG_HOME/docwatch/styles.css
            old = File.join(@config_dir, 'docwatch', 'styles.css')
            old if File.exist?(old)
        end

        def load
            path = File.join(@dir, 'config.toml')
            return nil unless File.exist?(path)

            TomlRB.parse(File.read(path))
        rescue TomlRB::ParseError => e
            $stderr.puts('Warning: failed to parse %s: %s' % [path, e.message])
            nil
        end
    end
end
