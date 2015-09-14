class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.integer :candidate_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
