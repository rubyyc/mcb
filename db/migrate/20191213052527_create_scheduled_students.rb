class CreateScheduledStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :scheduled_students do |t|
      t.integer :status
      t.belongs_to :student

      t.timestamps
    end
  end
end
