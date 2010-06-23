class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
    Role.create(:name => 'Administrator') unless Role.find_by_name('Administrator')
  end

  def self.down
    drop_table :roles
  end
end
