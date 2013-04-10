class ChangeStatusFromBooleanToString < ActiveRecord::Migration

  def change 
    change_column :user_events, :status, :string
  end

end
