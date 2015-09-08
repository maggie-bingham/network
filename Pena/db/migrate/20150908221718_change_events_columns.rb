class ChangeEventsColumns < ActiveRecord::Migration
  def change

    remove_column :events, :time

    add_column :events, :time, :string

  end
end
