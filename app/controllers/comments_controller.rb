class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(text: params[:text], user_id: current_user.id)
    @author = User.find(@post.author_id)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html do
          # redirect_to user_post_path(@author, @post), notice: 'Comment was successfully created.'
          redirect_to user_post_path(@post.user, @post), notice: 'Comment was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  private

  def comment_params
    puts params
    params.require(:comment).permit(:text)
  end
end
