class AddNetidAndClassAndNyuTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :netID, :string
    add_column :users, :nyu_class, :string
    add_column :users, :nyu_token, :string
  end
end
