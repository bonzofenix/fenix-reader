class AddChannelsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :max_channels, :integer, default: 10
  end
end
