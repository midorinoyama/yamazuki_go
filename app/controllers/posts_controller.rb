class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      tags = Vision.get_image_data(@post.image)# Visionモデルに画像を渡し解析
      tags.each do |tag|
        @post.tags.create(name: tag)
      end
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).per(12).reverse_order # 新着順で表示
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render :edit
    else
      redirect_to posts_path # 他人の投稿編集ページにurl入力しても遷移できないように
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       @post.tags.destroy_all
       tags = Vision.get_image_data(@post.image)# Visionモデルに画像を渡し解析
       tags.each do |tag|
         @post.tags.create(name: tag)
       end
      redirect_to post_path(@post.id), notice: "編集に成功しました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :filmed_on, :mountain, :prefecture)
  end
end
