class AddFailuresToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :failures, :integer
  end
end
