require_relative './application_record'

class Pageview < ApplicationRecord
 # Relationships
  belongs_to :view
  
  # Scopes 
  default_scope { order(timestamp: :asc) }
end
