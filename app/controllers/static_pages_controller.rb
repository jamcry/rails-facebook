class StaticPagesController < ApplicationController
  def index
    @post = current_user.posts.build
  end
end
