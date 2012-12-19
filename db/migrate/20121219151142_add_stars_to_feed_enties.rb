class AddStarsToFeedEnties < ActiveRecord::Migration
  def change
    add_column :feed_entries, :stars, :integer
  end
end
