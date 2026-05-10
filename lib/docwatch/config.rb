module Docwatch
    module Config
        STYLES_FILE = 'styles.css'

        def self.styles_path
            new_path = File.join(config_dir, 'org.crdx', 'docwatch', STYLES_FILE)
            old_path = File.join(config_dir, 'docwatch', STYLES_FILE)

            if File.exist?(new_path)
                new_path
            elsif File.exist?(old_path)
                old_path
            end
        end

        def self.config_dir
            ENV.fetch('XDG_CONFIG_HOME', File.expand_path('~/.config'))
        end

        private_class_method :config_dir
    end
end
