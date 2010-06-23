class TodoUserJoin < ActiveRecord::Migration
  def self.up
    create_table :todos_users, :id => false do |t|
      t.integer :todo_id, :null => false
      t.integer :user_id, :null => false
    end
  end

  def self.down
  end
end
