# frozen_string_literal: true

RSpec.describe Pageview do
  describe 'default scope' do
    let!(:first_pageview) { Pageview.create(timestamp: Time.new(2019, 1)) }
    let!(:second_pageview) { Pageview.create(timestamp: Time.new(2019, 2)) }

    it 'orders Pageviews by timestamp' do
      expect(Pageview.all).to eq [first_pageview, second_pageview]
    end
  end

  describe 'relationship with view' do
    it 'can access view model' do
      view = View.create(evid: '966634dc-0bf6-1ff7-f4b6-08000c95c670')
      pageview = view.pageviews.create

      expect(pageview.view).to eq(view)
    end
  end
end
