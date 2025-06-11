class AddPositionToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :position, :integer, default: 0, null: false
    add_index :tasks, [:list_id, :position]
  end
end