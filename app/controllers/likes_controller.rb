class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    @post.likes.build(user: current_user)
    if is_liked_by?(current_user)
      flash[:danger] = "You can't like a post more than once!"
    elsif @post.save
      flash[:success] = "Liked the post !"
      redirect_to stored_location_for(:user)
    else
      flash[:danger] = "An error prevented the like."
      redirect_to stored_location_for(:user)
    end  
  end

  def destroy
    @like = @post.likes.find_by(user: current_user).destroy
    redirect_to stored_location_for(:user)
  end

  private

      # Find the post to like
      def find_post
        @post = Post.find(params[:post_id])
      end

      # Find the like to unlike
      def find_like
        @like = @post.likes.find(params[:id])
      end

      # Returns true if the post is liked by user
      def is_liked_by?(user)
        @post.likes.where(user: user).exists?
      end
end
