# frozen_string_literal: true

# Handles call to service, parses statistics and stores them in models
class WebStatsHandler
  def initialize(mappings = {})
    @stats_json = stats

    @visit_mapping = mappings[:visit] || default_visit_mapping
    @pageview_mapping = mappings[:pageview] || default_pageview_mapping
  end

  def default_pageview_mapping
    {
      'url' => :url,
      'pageTitle' => :title,
      'timeSpent' => :time_spent,
      'timestamp' => :timestamp
    }
  end

  def default_visit_mapping
    {
      'referrerName' => :evid,
      'idSite' => :vendor_site_id,
      'idVisit' => :vendor_visit_id,
      'visitIp' => :visit_ip,
      'visitorId' => :vendor_visitor_id
    }
  end

  def stats
    WebStatsApiService.new.statistics
  end

  def parse_stats
    @parsed_stats = @stats_json.map do |visit|
      pageviews = visit['actionDetails'].map do |page_view|
        parse_and_map_hash @pageview_mapping, page_view
      end

      parsed_visit = parse_and_map_hash @visit_mapping, visit

      parsed_visit[:pageviews] = pageviews

      parsed_visit
    end
  end

  def save_stats
    @parsed_stats.each do |view_data|
      pageviews = view_data[:pageviews].each_with_index.map do |pageview, index|
        pageview[:position] = index + 1

        Pageview.new pageview
      end

      view_data[:pageviews] = pageviews

      View.create view_data
    end
  end

  # Helper methods

  def parse_and_map_hash(mapping, hash)
    hash.keys.each_with_object({}) do |k, new_hash|
      new_hash[mapping[k]] = hash[k] if mapping.key?(k)
    end
  end
end
