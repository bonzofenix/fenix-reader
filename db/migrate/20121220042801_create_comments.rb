class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :feed_entry

      t.timestamps
    end
  end
end
