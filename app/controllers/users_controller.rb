class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @limited_posts = @user.posts.limit(3)
    @all_posts = @user.posts.paginate(page: params[:page], per_page: 3)
  end

  def user_posts
    @user = User.find(params[:id])
    # @posts = @user.posts.includes(:comments, :user)
    @posts = @user.posts
  end
end
