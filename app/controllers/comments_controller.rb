class CommentsController < ApplicationController

  before_filter :login_required

  def index
    @todo = Todo.find(params[:todo_id])
    @comments = @todo.comments

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments.to_xml }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @comment = Comment.find(params[:id])
    @user = User.find(@comment.user_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment.to_xml }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @comment = Comment.new

  end

  # GET /articles/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    @todo = Todo.find(params[:todo_id])
    @comment = Comment.create(params[:comment])
    @todo.comments << @comment

    respond_to do |format|
      format.html { redirect_to todo_comments_url}
      format.xml  { render :xml => @comment.to_xml }

    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @comment = Comment.find(params[:id])

    @comment.update_attributes(params[:comment])
    respond_to do |format|
      format.html { redirect_to todo_comments_url}
      format.xml  { render :xml => @comment.to_xml }

    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to todo_comments_url}
      format.xml  { render :nothing => true }
    end
  end

end
