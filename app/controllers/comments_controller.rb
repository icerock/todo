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

  
  def show
    @comment = Comment.find(params[:id])
    @user = User.find(@comment.user_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment.to_xml }
    end
  end

  
  def new
    @comment = Comment.new

  end

  def edit
    @comment = Comment.find(params[:id])
  end

  
  def create
    @todo = Todo.find(params[:todo_id])
    @comment = Comment.create(:user_id => current_user.id,
      :comment_text => params[:comment][:comment_text])
    if @todo.comments << @comment
      flash[:notice] = "Comment created"
      respond_to do |format|
        format.html { redirect_to @todo}
        format.xml  { render :xml => @comment.to_xml }
      end
    else
      flash[:error] = "Error creating comment"
      respond_to do |format|
        format.html { redirect_to @todo}
        format.xml  { render :xml => @comment.to_xml }
      end
    end
  end

  
  def update
    @comment = Comment.find(params[:id])

    @comment.update_attributes(params[:comment])
    respond_to do |format|
      format.html { redirect_to todo_comments_url}
      format.xml  { render :xml => @comment.to_xml }

    end
  end

  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to todo_comments_url}
      format.xml  { render :nothing => true }
    end
  end

end
