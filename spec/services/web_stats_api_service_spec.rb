require './app/services/web_stats_api_service'

RSpec.describe WebStatsApiService do
  let!(:web_service) { WebStatsApiService.new }

  describe 'initializes to url' do
    it 'has default url' do
      expect(web_service.instance_variable_get('@url')).to_not be_nil
    end
  end
end
