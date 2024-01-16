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
          flash[:notice] = 'Comment created successfully.'
          redirect_to user_post_path(@post.user, @post)
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
