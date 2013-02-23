class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :display_image
      t.integer :school_id

      t.timestamps
    end
  end
end
