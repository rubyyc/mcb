class AddApprovedToTeacher < ActiveRecord::Migration[6.0]
  def self.up
    add_column :teachers, :approved, :boolean, :default => false, :null => false
    add_index  :teachers, :approved
  end

  def self.down
    remove_index  :teachers, :approved
    remove_column :teachers, :approved
  end
end
