class ToText2 < ActiveRecord::Migration
  def up
    change_column :comments, :description, :text, :limit => nil
    change_column :events, :name, :text, :limit => nil
    change_column :events, :location, :text, :limit => nil
    change_column :events, :description, :text, :limit => nil
    change_column :events, :image, :text, :limit => nil
    change_column :events, :blurb, :text, :limit => nil
    change_column :schools, :image, :text, :limit => nil
    change_column :user_events, :name, :text, :limit => nil
    change_column :users, :name, :text, :limit => nil
    change_column :users, :display_image, :text, :limit => nil
    change_column :users, :nyu_token, :text, :limit => nil
  end

  def down
    change_column :calendar, :redirect_uri, :string
    change_column :comments, :description, :string
    change_column :events, :name, :string
    change_column :events, :location, :string
    change_column :events, :description, :string
    change_column :events, :image, :string
    change_column :events, :blurb, :string
    change_column :schools, :image, :string
    change_column :user_events, :name, :string
    change_column :users, :name, :string
    change_column :users, :display_image, :string
    change_column :users, :nyu_token, :string
  end
end
