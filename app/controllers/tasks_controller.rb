class TasksController < ApplicationController

  before_filter :login_required
  before_filter :check_admin_role, :except => [:index, :show]

  def index
    @tasks = Task.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks.to_xml }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @task = Task.find(params[:id])
    @todos = @task.todos
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task.to_xml }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @task = Task.new

  end

  # GET /articles/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url}
      format.xml  { render :nothing => true }
    end
  end


end
