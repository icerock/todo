class TasksController < ApplicationController

  before_filter :login_required, :harv_connect
  #before_filter :check_admin_role, :except => [:index, :show]

  #HARVESTER OF SORROW :)

  require "harvest.rb"

  def harv_connect
    @harvest = Harvest(:email      => "anthony.icerock@gmail.com",
                       :password   => "Ice6667",
                       :sub_domain => "bambu4a",
                       :headers    => {"User-Agent" => "todo app"})

  end

  def index
    @tasks = @harvest.tasks.find(:all)
 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks.to_xml }
    end
  end

  def show
    @task = @harvest.tasks.find(params[:id])
    #@todos = @task.todos
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task.to_xml }
    end
  end

  def new
    @task = Task.new

  end

  def edit
    @task = @harvest.tasks.find(params[:id])
  end

  def create
    @task = @harvest.tasks.new

    @task.name = params[:task][:name]
    @task.billable_by_default = params[:task][:billable_by_default]
    @task.deactivated = params[:task][:deactivated]
    @task.default_hourly_rate = params[:task][:default_hourly_rate]
    @task.is_default = params[:task][:is_default]

    respond_to do |format|
      if @task.save
        flash[:error] = 'Task was successfully created.'
        format.html { render :action => "show" }
        format.xml  { render :xml => @task, :status => :created }
      else
        flash[:error] = 'Error creating task.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @task = @harvest.tasks.find(params[:id])
    #@task = params[:harvest_resources_task]
    @task.name = params[:harvest_resources_task][:name]
    @task.billable_by_default = params[:harvest_resources_task][:billable_by_default]
    @task.deactivated = params[:harvest_resources_task][:deactivated]
    @task.default_hourly_rate = params[:harvest_resources_task][:default_hourly_rate]
    @task.is_default = params[:harvest_resources_task][:is_default]

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully updated.'
        format.html { render :action => "show"}
        format.xml  { head :ok }
      else
        flash[:error] = 'Error updating task.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = @harvest.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url}
      format.xml  { render :nothing => true }
    end
  end

end
