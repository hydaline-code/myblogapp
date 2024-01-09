class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def user_posts
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments, :user)  # Fetch posts with associated comments and user
  end
end
