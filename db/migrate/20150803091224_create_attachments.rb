class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :job_id, null: false
      t.integer :status, null: false
      t.string :file,   null: false

      t.timestamps null: false
    end
  end
end
