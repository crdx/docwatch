require_relative 'lib/docwatch/version'

Gem::Specification.new do |spec|
    spec.homepage = 'https://github.com/crdx/docwatch'
    spec.summary = 'Preview markdown documents in the browser with reload on change'
    spec.name = 'docwatch-bin'
    spec.version = Docwatch::VERSION
    spec.author = 'crdx'
    spec.license = 'GPLv3'
    spec.metadata['rubygems_mfa_required'] = 'true'

    spec.required_ruby_version = '>= 3.0'

    spec.files = Dir['{lib,res}/**/*']
    spec.executables = ['docwatch']

    spec.add_dependency 'colorize', '~> 0.8.1'
    spec.add_dependency 'docopt', '~> 0.6.1'
    spec.add_dependency 'json', '~> 2.7'
    spec.add_dependency 'nokogiri', '~> 1.10'
    spec.add_dependency 'redcarpet', '~> 3.5'
    spec.add_dependency 'rouge', '~> 4.0'

    spec.add_development_dependency 'rake', '~> 13.0'
end
