class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :code
      t.string :client_id
      t.string :client_secret
      t.string :redirect_uri
      t.string :access_token
      t.string :refresh_token

      t.timestamps
    end
  end
end
