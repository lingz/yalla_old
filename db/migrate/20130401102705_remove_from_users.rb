class RemoveFromUsers < ActiveRecord::Migration
  def up
    add_column :users, :event_user_id, :integer
    add_column :events, :event_user_id, :integer
  end

  def down
    remove_column :users, :event_user_id
    remove_column :events, :event_user_id
  end
end
