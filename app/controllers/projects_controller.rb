class ProjectsController < ApplicationController

  before_filter :login_required, :harv_connect
  #before_filter :check_admin_role, :except => [:index, :show]

  
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
    #@todos = @task.todos
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project.to_xml }
    end
  end

  def new
    @project = Project.new

  end

  def edit
    @project = @harvest.projects.find(params[:id])
    #@clients = @harvest.clients.find(:all)
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
        format.html { render :action => "show" }
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
    #@project = params[:harvest_resources_project].to_array
    @project.attributes = {:name => params[:project][:name],
                           :active => params[:project][:active],
                           :billable => params[:project][:billable],
                           
                           :hourly_rate => params[:project][:hourly_rate],
                           
                           :code => params[:project][:code],
                           :notes => params[:project][:notes],
                           
                           :budget => params[:project][:budget],
                           
                          }
    

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully updated.'
        format.html { render :action => "show"}
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

end