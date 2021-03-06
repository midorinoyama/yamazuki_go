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
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(16)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(16)
  end

  def favorites
    @user = User.find(params[:id])
    @favorite_posts = @user.favorite_posts.page(params[:page]).per(12)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "このユーザーは退会しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :profile_image, :introduction, :gender, :age, :prefecture)
  end
end
