class AddSourceToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :source, :string
  end
end
