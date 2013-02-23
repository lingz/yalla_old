class AddCalendarIdToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :calendar_id, :string
  end
end
