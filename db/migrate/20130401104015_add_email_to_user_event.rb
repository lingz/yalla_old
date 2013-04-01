class AddEmailToUserEvent < ActiveRecord::Migration
  def change
    add_column :user_events, :email, :string
  end
end
