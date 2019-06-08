class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User created!"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  private

      def user_params
        params.require(:user).permit(:first_name, :surname, :email, :password, :birthday, :gender_id)
      end
end
