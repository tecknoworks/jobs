class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :full_name
      t.string :phone_number
      t.string :email

      t.timestamps null: false
    end
  end
end
