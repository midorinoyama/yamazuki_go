class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    #コメントをする対象の投稿を見つける
    post_comment = PostComment.new(post_comment_params)
    #新規コメントを作成
    post_comment.user_id = current_user.id
    # (ログインしている)userに紐づいたコメントを取得
    post_comment.post_id = @post.id
    #投稿に紐づいたコメントを取得
    if post_comment.save
      redirect_to post_path(@post.id)
    else
      render 'posts/show'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    redirect_to post_path(post.id)
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment, :parent_id)
  end

end