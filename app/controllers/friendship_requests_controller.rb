class FriendshipRequestsController < ApplicationController
  def create
    requested_user = User.find(params[:requested_user_id])
    @friendship_request = current_user.friendship_requests.build(requested_user: requested_user)
    if @friendship_request.save
      flash[:success] = "Friendship request was sent!"
      redirect_to @friendship_request.requested_user
    end
  end

  def destroy
    @friendship_request = FriendshipRequest.find(params[:id])
    @friendship_request.destroy
    flash[:info] = "Friend request was cancelled."
    redirect_to stored_location_for(:user)
  end
end
