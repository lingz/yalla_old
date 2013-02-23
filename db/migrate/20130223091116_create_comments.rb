class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
