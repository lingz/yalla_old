class AddStatusToUserEvent < ActiveRecord::Migration
  def change
    add_column :user_events, :status, :boolean
  end
end
