require './app/models/pageview.rb'
require './app/models/view.rb'

RSpec.describe View do
  let!(:valid_view) { View.create(evid: '966634dc-0bf6-1ff7-f4b6-08000c95c670') }

  describe 'validation' do
    let!(:invalid_view) { View.create(evid: '08000c95c670') }

    it 'validates evid regex' do
      expect(valid_view).to be_valid
      expect(invalid_view).to_not be_valid
    end
  end

  describe 'evid parse' do
    it 'removes evid_ prefix' do
      prefixed_evid = 'evid_966634dc-0bf6-1ff7-f4b6-08000c95c670'
      parsed_evid = '966634dc-0bf6-1ff7-f4b6-08000c95c670'

      view = View.create(evid: prefixed_evid)

      expect(view.evid).to eq(parsed_evid)
    end
  end

  describe 'relationship with pageview' do

    it 'can access pageview model' do
      parent_view = valid_view
      pageview = parent_view.pageviews.create

      expect(parent_view.pageviews).to eq [pageview]
    end
  end
end
