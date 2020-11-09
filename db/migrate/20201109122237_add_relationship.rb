class AddRelationship < ActiveRecord::Migration[6.0]
  def change
    add_reference :pageviews, :view, index: true
  end
end
