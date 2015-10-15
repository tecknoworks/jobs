class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.integer :user_id
      t.string :consumer_key
      t.string :secret_key

      t.timestamps null: false
    end
  end
end
