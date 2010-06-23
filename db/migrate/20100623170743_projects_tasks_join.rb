class ProjectsTasksJoin < ActiveRecord::Migration
  def self.up
    create_table :projects_tasks, :id => false do |t|
      t.integer :project_id, :null => false
      t.integer :task_id, :null => false
    end
  end

  def self.down
  end
end
