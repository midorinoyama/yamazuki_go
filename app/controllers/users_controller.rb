class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(16).order(nickname: :asc) # orderメソッドで名前の昇順
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(11).order(filmed_on: :desc) # pageメソッドでそのユーザーに紐づく投稿orderで撮影日の新着順
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id) # 他ユーザーのeditページにurl入力しても遷移できない
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "編集に成功しました"
    else
      render :edit
    end
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings.page(params[:page]).per(16)
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page]).per(16)
  end

  def favorites
    user = User.find(params[:id])
    favorites = Favorite.where(user_id: user.id).pluck(:post_id)
    # pluck:指定したモデルのカラムのレコードをすべて取得(そのユーザーがいいねしたpost_idをfavoritesテーブルから検索)
    @favorite_posts = Post.find(favorites)
    # 見つけたpost_idの情報をPostsテーブルから探し代入
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(12)
    # findやwhereメソッドはArrayオブジェクト(配列)、pageの使用方法が変わる(通常はActiveRecordオブジェクトに対して)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :profile_image, :introduction, :gender, :age, :prefecture)
  end
end
