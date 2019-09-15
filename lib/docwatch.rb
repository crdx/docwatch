require 'require_all'
require 'colorize'
require 'docopt'
require 'redcarpet'
require 'nokogiri'

require 'socket'
require 'ostruct'

require_rel 'docwatch'

module Docwatch
    def self.root
        File.expand_path('../..', __FILE__)
    end
end
