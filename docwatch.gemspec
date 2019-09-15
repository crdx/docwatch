require_relative 'lib/docwatch/version'

Gem::Specification.new do |spec|
    spec.homepage = 'https://github.com/crdx/docwatch'
    spec.summary  = ''
    spec.name     = 'docwatch'
    spec.version  = Docwatch::VERSION
    spec.author   = 'crdx'
    spec.license  = 'GPLv3'

    spec.files    = Dir['{lib}/**/*']
    spec.executables = ['docwatch']

    spec.add_runtime_dependency 'require_all', '~> 2.0'
    spec.add_runtime_dependency 'colorize', '~> 0.8.1'
    spec.add_runtime_dependency 'docopt', '~> 0.6.1'
    spec.add_runtime_dependency 'redcarpet', '~> 3.5'

    spec.add_development_dependency 'simplecov', '~> 0.17.0'
    spec.add_development_dependency 'rspec', '~> 3.8'
    spec.add_development_dependency 'rake', '~> 12.3'
end
