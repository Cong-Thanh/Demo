class CreateTaskItems < ActiveRecord::Migration
  def change
    create_table :task_items do |t|
      t.string :description
      t.date :due_date
      t.references :task

      t.timestamps
    end
  end
end
