class ChangeColumnsToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :lat
    remove_column :events, :lon

    add_column :events, :lon, :float
    add_column :events, :lat, :float
  end
end
