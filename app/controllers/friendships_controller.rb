class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:friend_id])
    @friendship = @friend.friendships.build(friend: current_user)
    @inverse_friendship = current_user.friendships.build(friend: @friend)
    @request = FriendshipRequest.find_by(user_id: params[:friend_id],
                                          requested_user_id: current_user.id)
    if @friendship.save && @inverse_friendship.save
      flash[:success] = "You are now friends with #{@friend.full_name}!"
      @request.destroy if @request
      redirect_to user_path(@friend)
    else
      flash[:danger] = "The friendship couldn't be created!"
      redirect_to stored_location_for(:user)
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @inverse_friendship = inverse_friendship(@friendship)
    @friendship.destroy
    @inverse_friendship.destroy
    redirect_to stored_location_for(:user) || root_url
  end

  private

      def inverse_friendship(friendship)
        @user_id = @friendship.user.id
        @friend_id = @friendship.friend.id
        Friendship.find_by(user_id: @friend_id, friend_id: @user_id)
      end
end
