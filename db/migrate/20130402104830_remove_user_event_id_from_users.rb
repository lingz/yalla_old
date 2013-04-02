class RemoveUserEventIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :user_event_id
  end

  def down
    add_column :users, :user_event_id, :integer
  end
end
