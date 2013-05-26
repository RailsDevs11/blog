class Public::BlogsController < Public::BaseController
  before_filter :authenticate_user!, :except => [:index, :show, :create]
  before_filter :is_login?, :only => [:create]
  
  def index
    @posts = Post.created_at_order
  end

  def show
    @post = Post.where(:id => params[:id]).first
    @comment = @post.comments.new
    @comments = @post.comments.created_at_order
  end
  
  #
  def create    
    @comment = @post.comments.new(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { 
          flash[:notice] = 'Comment was successfully created.' 
        }
      else
        format.js { 
          flash[:error] = @comment.errors.full_messages.join('<br/>')
        }
      end
    end
    @comments = @post.comments.created_at_order
  end

  def destroy
    @post = Post.where(:id => params[:post_id]).first
    @comment = @post.comments.where(:id => params[:id]).first
    @comment.destroy if @comment.is_owner?(current_user.id)

    respond_to do |format|
      format.js { 
        @comments = @post.comments.created_at_order
        flash[:notice] = 'Comment was successfully deleted'
        render action: :create 
      }
    end  
  end

  #Like or unlike a post
  def like
    post_id = params[:id]
    @post = Post.where(:id => post_id).first
    if current_user && @post
      if @post.is_like?(current_user.id)
        @post.unlike(current_user.id)
        render :text => "<span class='badge badge-success'> #{@post.get_likes_count}</span> Like" 
      else
        @post.like(current_user.id)
        render :text => "<span class='badge badge-success'> #{@post.get_likes_count}</span> UnLike" 
      end
      return
    end
    render :text => 'fail' and return
  end 

  private
  
  #check, if user is not login 
  #then check and and visitor not able to create comment
  def is_login?
    @post = Post.where(:id => params[:id]).first
    unless current_user.present?
      respond_to do |format|
        format.js { 
          @comments = @post.comments.created_at_order
          flash[:error] = "You need to sign in or sign up before continuing." 
          render action: :create and return true 
        }
      end
    end
  end 
  
end
