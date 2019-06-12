class FriendshipsController < ApplicationController
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
