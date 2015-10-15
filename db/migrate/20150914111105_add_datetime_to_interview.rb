class AddDatetimeToInterview < ActiveRecord::Migration
  def change
    add_column :interviews, :date_and_time, :datetime
  end
end
