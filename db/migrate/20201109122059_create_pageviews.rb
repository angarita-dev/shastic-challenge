class CreatePageviews < ActiveRecord::Migration[6.0]
  def change
    create_table :pageviews do |t|
      t.string :title
      t.string :position
      t.text :url
      t.string :time_spent
      t.decimal :timestamp, precision: 14, scale: 3
    end
  end
end
