class AddNameToUserEvent < ActiveRecord::Migration
  def change
    add_column :user_events, :name, :string
  end
end
