# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir('./app/')
loader.push_dir('./app/models')
loader.push_dir('./app/services')
loader.push_dir("#{__dir__}/lib/api_faker")
loader.setup

def setup
  ApiFaker.new.setup_stub
end

def call
  setup

  web_stats_handler = WebStatsHandler.new
  web_stats_handler.parse_stats
  web_stats_handler.save_stats
end
