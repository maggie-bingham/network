class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :urlname, :string
  end
end
