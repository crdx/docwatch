require 'require_all'
require 'redcarpet'
require 'colorize'
require 'nokogiri'
require 'docopt'

require 'ostruct'
require 'socket'
require 'yaml'
require 'cgi'

module Docwatch
    def self.root_dir
        File.expand_path('..', __dir__)
    end
end

require_rel 'docwatch'
