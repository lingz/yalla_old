class RemovePasswordFromUser < ActiveRecord::Migration
  def up
  end

  def down
    remove_column :user, :password
  end
end
