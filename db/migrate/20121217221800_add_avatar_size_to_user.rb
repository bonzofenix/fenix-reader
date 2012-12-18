class AddAvatarSizeToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_size, :integer, default: 200
  end
end
