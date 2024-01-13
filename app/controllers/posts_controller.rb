class PostsController < ApplicationController
  before_action :find_user
  before_action :find_post, only: [:show]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 2)
  end

  def show; end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.create(title: params[:title], text: params[:text], author_id: current_user.id, comments_counter: 0,
                        likes_counter: 0)
    puts "post id is #{@post.id}"
    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post created successfully.'
    else
      render :ne
    end
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

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
