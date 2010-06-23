class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :task_name
      t.text :description
      t.integer :project_id
      t.boolean :billable, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
