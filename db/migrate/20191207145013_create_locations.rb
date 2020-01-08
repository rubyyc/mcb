class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.integer :teacher_id
      t.time :start_time
      t.time :end_time
      t.integer :weekday
      t.integer :place

      t.timestamps
    end
  end
end
