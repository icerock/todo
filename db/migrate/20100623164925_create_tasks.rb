class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.integer :project_id
      t.boolean :billable_by_default, :default => false
      t.boolean :deactivated, :default => false
      t.decimal :default_hourly_rate
      t.boolean :is_default, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
