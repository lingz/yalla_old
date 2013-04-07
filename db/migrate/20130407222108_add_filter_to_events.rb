class AddFilterToEvents < ActiveRecord::Migration
  def change
    add_column :events, :filter, :integer
  end
end
