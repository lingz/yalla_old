class AddLastCleanupToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :last_cleanup, :datetime
  end
end
