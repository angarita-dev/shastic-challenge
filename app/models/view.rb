# frozen_string_literal: true

require_relative 'application_record'

# Stores visit statistics, related with pageviews
class View < ApplicationRecord
  # Relationships
  has_many :pageviews

  # Validations
  validates :evid,
            presence: true,
            format: {
              with: /\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/
            }

  # Callbacks
  before_validation do
    evid.delete_prefix! 'evid_' if attribute_present?('evid')
  end
end
