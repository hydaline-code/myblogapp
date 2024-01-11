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
    find_user
    @post = @user.posts.find_by(id: params[:id])
  # Check if both the user and the post exist
 
  unless @post
    respond_to do |format|
      format.html { render 'post_not_found' }
      format.js   { render 'post_not_found' }
    end
    end
  end
end
