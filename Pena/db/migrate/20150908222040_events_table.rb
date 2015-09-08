class EventsTable < ActiveRecord::Migration
  def change

    remove_column :events, :time

    add_column :events, :date, :string
    
  end
end
