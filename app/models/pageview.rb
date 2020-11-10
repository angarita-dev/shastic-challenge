# frozen_string_literal: true

require_relative 'application_record'

# Stores the pageview statistics
class Pageview < ApplicationRecord
  # Relationships
  belongs_to :view

  # Scopes
  default_scope { order(timestamp: :asc) }
end
