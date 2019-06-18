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
    @post = current_user.posts.build if user_signed_in?
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end


  private

      def user_params
        params.require(:user).permit(:first_name, :surname, :email, :password, :birthday, :gender_id)
      end

      def send_welcome_email
        # Set UserMailer to send a welcome email after save
        UserMailer.with(user: @user).welcome_email.deliver_now
      end
end
