class RolesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @all_roles = Role.find(:all)
  end

  def update
    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    @user.roles << @role unless @user.has_role?(@role.name)
    redirect_to :action => 'index'
  end

  def destroy
    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    @user.roles.delete(@role) if @user.has_role?(@role_name)
    redirect_to :action => 'index'
  end

end
