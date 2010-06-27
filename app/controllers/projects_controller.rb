class ProjectsController < ApplicationController

  before_filter :login_required, :harv_connect, :set_pagetitle
  
  
  def set_pagetitle
    @pagetitle = 'Working with projects'
  end

  def index
    @projects = @harvest.projects.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects.to_xml }
    end
  end

  def show
    @project = @harvest.projects.find(params[:id])
    @tasks = @project.tasks.find(:all)
    @tasks.each do |t|
      @task = @harvest.tasks.find(t.task_id)
      t.name = @task.name
    end
    @normal_tasks = @harvest.tasks.find(:all)
    @todos = Todo.find_all_by_project_id(@project.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project.to_xml }
    end
  end

  def new
    @project = Project.new
    @clients = @harvest.clients.find(:all)

  end

  def edit
    @project = @harvest.projects.find(params[:id])
    @clients = @harvest.clients.find(:all)

  end

  def create
    @project = @harvest.projects.new
    #@clients = @harvest.clients.find(:all)
    
    @project.attributes = {:name => params[:project][:name],
                           :active => params[:project][:active],
                           :billable => params[:project][:billable],
                           :bill_by => params[:project][:bill_by],
                           :hourly_rate => params[:project][:hourly_rate],
                           :client_id => params[:project][:client_id],
                           :code => params[:project][:code],
                           :notes => params[:project][:notes],
                           :budget_by => params[:project][:budget_by],
                           :budget => params[:project][:budget],
                           :fees => params[:project][:fees]
                          }

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to '/projects' }
        format.xml  { render :xml => @project, :status => :created }
      else
        flash[:error] = 'Error creating project.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @project = @harvest.projects.find(params[:id])
    
    @project.name = params[:harvest_resources_project][:name]
    @project.active = params[:harvest_resources_project][:active]
    @project.billable = params[:harvest_resources_project][:billable]
    @project.bill_by = params[:harvest_resources_project][:bill_by]
    @project.hourly_rate = params[:harvest_resources_project][:hourly_rate]
    @project.client_id = params[:harvest_resources_project][:client_id]
    @project.code = params[:harvest_resources_project][:code]
    @project.notes = params[:harvest_resources_project][:notes]
    @project.budget_by = params[:harvest_resources_project][:budget_by]
    @project.budget = params[:harvest_resources_project][:budget]
    @project.fees = params[:harvest_resources_project][:fees]
                           

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to '/projects'}
        format.xml  { head :ok }
      else
        flash[:error] = 'Error updating project.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = @harvest.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url}
      format.xml  { render :nothing => true }
    end
  end

  def activate
    @project = @harvest.projects.find(params[:id])
    respond_to do |format|
      if @project.toggle
        flash[:notice] = 'Project was successfully activated.'
        format.html { redirect_to '/projects'}
        format.xml  { head :ok }
      else
        flash[:error] = 'Error activating project.'
        format.html { redirect_to '/projects' }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

end