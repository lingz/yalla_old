class RemoveAttendingUsersIdFromUsersAndEvents < ActiveRecord::Migration
  def up
    remove_column :users, :attending_user_id
    remove_column :events, :attending_user_id
  end

  def down
  end
end
