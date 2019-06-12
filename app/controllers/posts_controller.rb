class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to stored_location_for(:user)
    else
      flash[:danger] = "Cannot create new post"
      redirect_to stored_location_for(:user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to stored_location_for(:user)
  end


  private

      def post_params
        params.require(:post).permit(:body)
      end
end
