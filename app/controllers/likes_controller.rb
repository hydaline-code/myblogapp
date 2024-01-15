# class LikesController < ApplicationController
#   def create
#     @post = Post.find(params[:post_id])
#     @like = @post.likes.new(user: current_user)

#     if @like.save
#       redirect_to post_path(@post), notice: 'Post liked successfully.'
#     else
#       redirect_to post_path(@post), alert: 'Failed to like the post.'
#     end
#   end
# end


class LikesController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id] || params[:id])
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id] || params[:id])
    # @like = Like.new(post_id: @post.id)
    # @author = User.find(@post.author_id)
    @like = @post.likes.new(user: current_user)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(@post.user, @post), notice: 'Like was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
end