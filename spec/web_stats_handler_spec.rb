require './app/web_stats_handler'
require './app/services/web_stats_api_service'

RSpec.describe WebStatsHandler do
  let!(:instance) { WebStatsHandler.new }

  describe '#get_stats' do
    it 'returns WebStatsApiService::statistics' do
      expect(instance.get_stats).to eq(WebStatsApiService.new.statistics)
    end
  end

  describe '#parse_stats' do
    it 'sets @parsed_states' do
      current_instance = instance

      expect(current_instance.instance_variable_get(:@parsed_stats)).to be_nil
      current_instance.parse_stats
      expect(current_instance.instance_variable_get(:@parsed_stats)).to_not be_nil
    end

    it 'contains keys from mappings' do
      mapped_keys = %w[
        url
        title
        time_spent
        timestamp
        evid
        vendor_visitor_id
        visit_ip
        vendor_visit_id
        vendor_site_id
        pageviews
      ]

      parsed_stats = instance.parse_stats

      parsed_stats.each do |hash|
        hash.keys.map(&:to_s).each do |key|
          expect(mapped_keys).to include(key)
        end
      end
    end
  end

  describe '#save_stats' do
    it 'creates records to db' do
      expect(Pageview.count).to eq(0)
      expect(View.count).to eq(0)

      instance.parse_stats
      instance.save_stats

      expect(Pageview.count).to_not eq(0)
      expect(View.count).to_not eq(0)
    end
  end
end
