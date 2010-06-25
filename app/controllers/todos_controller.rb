class TodosController < ApplicationController

  before_filter :login_required, :set_pagetitle

  def set_pagetitle
    @pagetitle = 'TODO Items'
  end

  def index
    @todos = Todo.find(:all, :order => :task_id)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todos }
    end
  end

  def show
    @todo = Todo.find(params[:id])
    @comments = @todo.comments
    @users = @todo.users
    harv_connect
    if @todo.task_id.to_i > 0
      
      @task = @harvest.tasks.find(@todo.task_id)
    else
      @task= nil
    end
    if @todo.project_id.to_i > 0
      @project = @harvest.projects.find(@todo.project_id)
    else
      @project= nil
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  def new
    @todo = Todo.new
    harv_connect
    @normal_tasks = @harvest.tasks.find(:all)
    @projects = @harvest.projects.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def create
    @todo = Todo.create(params[:todo])
    if params[:project_id]
    @todo.project_id = params[:project_id]
    else
      @todo.project_id = params[:todo][:project_id]
    end
    
    if @todo.save
      respond_to do |format|
        format.html { redirect_to todos_path }
        format.xml  { render :xml => @todo.to_xml}
      end
    else
      flash[:error] = "Error creating TODO"
      respond_to do |format|
        format.html { redirect_to todos_url}
        format.xml  { render :xml => @todo.to_xml }
      end
    end
  end

  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to(@todo, :notice => 'TODO was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to(todos_url) }
      format.xml  { head :ok }
    end
  end

  def my
    @user = User.find(current_user.id)
    @todos = @user.todos
      respond_to do |format|
        flash[:notice] = 'Grab your TODOs and get to work! :)'
        format.html { render @todos, :template => '/todos/index', :layout => true  }
        format.xml  { render :xml => @todos.to_xml}
      end

  end

end
