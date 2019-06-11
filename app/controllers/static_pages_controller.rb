class StaticPagesController < ApplicationController
  def index
    @post = current_user.posts.build if user_signed_in?
  end
end
