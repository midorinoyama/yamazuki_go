class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order#pageメソッドでそのユーザーに紐づく投稿のみ表示
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def favorites
    user = User.find(params[:id])
    favorites = Favorite.where(user_id: user.id).pluck(:post_id)
    #pluck:指定したモデルのカラムのレコードをすべて取得(User.findで取得したidのユーザーがいいねしたレコードと一緒にpost_idを取得)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :profile_image, :introduction, :gender,:age, :prefecture)
  end
end
