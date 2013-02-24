class AddIdsToEvents < ActiveRecord::Migration
  def up
    add_column :events, :ids, :string
  end
  def down
  end

end
