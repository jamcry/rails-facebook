class CommentsController < ApplicationController
  before_action :find_post, only: [:new, :create]

  def new
    @comment = Post.find(params[:id]).comments.build
  end

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to user_path(@post.user)
    else
      flash[:danger] = "Cannot create comment"
      redirect_to user_path(@post.user)
    end
  end

  private
      # before filter for finding post to comment
      def find_post
        @post = Post.find(params[:post_id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
end
