class AddLastUpdateToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :last_update, :datetime
  end
end
