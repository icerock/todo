class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.boolean :active, :default => false
      t.boolean :billable, :default => false
      t.integer :bill_by
      t.decimal :hourly_rate
      t.integer :client_id
      t.string :code
      t.text :notes
      t.integer :budget_by
      t.decimal :budget
      t.string :fees
      
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
