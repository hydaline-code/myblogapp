class PostsController < ApplicationController
  before_action :find_user
  before_action :find_post, only: [:show]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    find_user
    @post = @user.posts.find_by(id: params[:id])

    #   return if @post

    #   respond_to do |format|
    #     format.html { render 'post_not_found'and return }
    #     format.js { render 'post_not_found' and return }
    #   end
    # end

    return unless @post.nil?

    flash[:error] = 'Post not found'
    redirect_to user_path(@user)
  end
end
