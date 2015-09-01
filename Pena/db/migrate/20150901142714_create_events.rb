class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.text :description
      t.time :time
      t.date :date

      t.timestamps null: false
    end
  end
end
