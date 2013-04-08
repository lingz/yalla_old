class AddCallsToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :calls, :integer
  end
end
