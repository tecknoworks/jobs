class AddFileToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :file, :file
  end
end
