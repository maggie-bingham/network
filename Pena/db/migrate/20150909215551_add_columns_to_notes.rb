class AddColumnsToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :user_id, :integer
    add_column :notes, :author_id, :integer
  end
end
