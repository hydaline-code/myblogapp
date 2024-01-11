class PostsController < ApplicationController
  before_action :find_user
  before_action :find_post, only: [:show]
  
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show

  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end 

  def find_post
    @post = @user.posts.find(params[:id])
  end
end
