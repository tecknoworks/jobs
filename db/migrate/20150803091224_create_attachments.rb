class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :job_id, null: false
      t.integer :status, default: 0 #Draft
      t.string :file,   null: false, default: 'default.txt'

      t.timestamps null: false
    end
  end
end
