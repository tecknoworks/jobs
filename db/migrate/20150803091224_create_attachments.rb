class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :job_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
