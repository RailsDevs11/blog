class User::PostsController < User::BaseController
  before_filter :authenticate_user!
  before_filter :is_post_exist?, :except => [:index, :new, :create]
  
  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.where(:id => params[:id]).first
  end

  def new
    @post = current_user.posts.new
  end

  def edit
    @post = current_user.posts.where(:id => params[:id]).first
  end

  def create
    @post = current_user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @post = current_user.posts.where(:id => params[:id]).first

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to user_posts_path, notice: 'Post was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @post = current_user.posts.where(:id => params[:id]).first
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_path, notice: 'Post was successfully deleted.'  }
    end
  end
  
  private
  #checking fo post and if post not present it return
  def is_post_exist?
    @post = current_user.posts.where(:id => params[:id]).first
    unless @post.present?
      redirect_to user_posts_path, notice: 'You dont have access to requested post'
    end
  end
  
end
