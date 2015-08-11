class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :candidate_id, null: false
      t.integer :user_id, null: false
      t.integer :status, default: 0 # Draft
      t.string :file, null: false

      t.timestamps null: false
    end
  end
end
