class ChangeColumnInEvents < ActiveRecord::Migration
  def change
    remove_column :events, :external_id

    add_column :events, :external_id, :string
  end
end
