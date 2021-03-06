# frozen_string_literal: true

# Service for consuming external API
class WebStatsApiService
  require 'json'
  require 'httparty'

  def initialize(url = 'http://www.shastic-challenge.fake-data.com')
    @url = url
  end

  def statistics
    JSON.parse(HTTParty.get(@url).body)
  end
end
