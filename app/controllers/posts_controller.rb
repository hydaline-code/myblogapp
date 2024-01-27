class PostsController < ApplicationController
  before_action :find_user
  before_action :find_post, only: [:show]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:user, :comments).paginate(page: params[:page], per_page: 2)
    #    @posts = @user.posts.paginate(page: params[:page], per_page: 2)
  end

  def show; end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(author_id: current_user.id, comments_counter: 0, likes_counter: 0))

    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_path(user_id: @post.author_id) }
      format.js
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    find_user
    @post = @user.posts.find_by(id: params[:id])

    return unless @post.nil?

    flash[:error] = 'Post not found'
    redirect_to user_path(@user)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
