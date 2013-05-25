class Public::BlogsController < Public::BaseController
  before_filter :authenticate_user!, :except => [:index, :show]
  #layout "dashboard"
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.where(:id => params[:id]).first
    @comment = Comment.new
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
