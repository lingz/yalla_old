class AddAttendingUsersIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :attending_user_id, :integer
    add_column :events, :attending_user_id, :integer
  end
end
