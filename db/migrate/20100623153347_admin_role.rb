class AdminRole < ActiveRecord::Migration
  def self.up
    admin_user = User.find_by_login ('Admin')
    admin_role = Role.find_by_name('Administrator')
    admin_user.roles << admin_role
  end

  def self.down
  end
end
