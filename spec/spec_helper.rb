require 'simplecov'

SimpleCov.start do
    add_filter '/spec/'
    add_filter '/vendor/'
end

require_relative '../lib/docwatch'
include Docwatch
