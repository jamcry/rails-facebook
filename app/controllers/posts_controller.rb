class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to current_user
    else
      flash[:danger] = "Cannot create new post"
      redirect_to current_user
    end
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end
end
