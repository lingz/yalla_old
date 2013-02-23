class AddUniqueIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :unique_id, :string
  end
end
