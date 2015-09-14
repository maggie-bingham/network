class ChangeEventsTable < ActiveRecord::Migration
  def change

    add_column :events, :external_id, :integer
    add_column :events, :group_name, :string
    add_column :events, :venue_name, :string
    add_column :events, :address, :string

    remove_column :events, :name
    remove_column :events, :location
    remove_column :events, :date

  end
end
