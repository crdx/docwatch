require 'rouge'
require 'rouge/plugins/redcarpet'
require 'redcarpet'
require 'colorize'
require 'nokogiri'
require 'docopt'

require 'ostruct'
require 'socket'
require 'yaml'
require 'cgi'
require 'date'

module Docwatch
    def self.root_dir
        File.expand_path('..', __dir__)
    end
end

require_relative 'docwatch/connection'
require_relative 'docwatch/logger'
require_relative 'docwatch/parser'
require_relative 'docwatch/parser/frontmatter'
require_relative 'docwatch/renderer'
require_relative 'docwatch/renderer/html'
require_relative 'docwatch/renderer/markdown'
require_relative 'docwatch/session'
require_relative 'docwatch/util/html'
require_relative 'docwatch/version'
require_relative 'docwatch/watcher'
