class WebStatsApiService       
  def initialize               
    @url = 'http://www.shastic-challenge.fake-data.com'
  end

  def statistics               
    JSON.parse(HTTParty.get(@url).body)
  end
end 
