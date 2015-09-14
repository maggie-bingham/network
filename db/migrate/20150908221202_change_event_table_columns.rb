class ChangeEventTableColumns < ActiveRecord::Migration
  def change

    remove_column :events, :time

    add_column :events, :time, :integer

  end
end
