class AddTestFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :foo, :string
  end
end
