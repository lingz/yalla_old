class AddBlurbToEvent < ActiveRecord::Migration
  def change
    add_column :events, :blurb, :string
  end
end
