class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :url
      t.references :user
      t.timestamps
    end
  end
end
