class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.datetime :due_time
      t.integer :task_id
      t.integer :user_id
      t.boolean :completed, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
