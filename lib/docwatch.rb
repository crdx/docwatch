require 'require_all'
require 'redcarpet'
require 'colorize'
require 'nokogiri'
require 'docopt'

require 'ostruct'
require 'socket'

module Docwatch
    def self.root_dir
        File.expand_path('../..', __FILE__)
    end
end

require_rel 'docwatch'
