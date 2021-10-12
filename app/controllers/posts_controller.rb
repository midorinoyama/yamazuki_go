class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.ner(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image, :filmed_on, :mountain, :prefecture)
  end

end
