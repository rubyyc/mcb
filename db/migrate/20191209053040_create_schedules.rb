class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :student_id
      t.integer :teacher_id
      t.integer :location_id
      t.integer :scheduled_student_id
      t.integer :scheduled_times
      t.datetime :next_start_time

      t.timestamps
    end
  end
end
