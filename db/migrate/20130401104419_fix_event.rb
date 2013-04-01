class FixEvent < ActiveRecord::Migration
  def up
    remove_column :users, :event_user_id
    remove_column :events, :event_user_id
    add_column :users, :user_event_id, :integer
    add_column :events, :user_event_id, :integer
  end

  def down
    add_column :users, :event_user_id, :integer
    add_column :events, :event_user_id, :integer
  end
end
