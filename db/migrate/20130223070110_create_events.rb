class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :user_id
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.string :image
      t.string :status

      t.timestamps
    end
  end
end
