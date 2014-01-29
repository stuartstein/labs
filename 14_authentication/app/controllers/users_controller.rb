class UsersController < ApplicationController
  
  def new
  	@user = User.new()
  	render :sign_up
  end
  
  def create
  	@user = User.new(user_params)

  	if @user.save
  		#sign_in @user
  		redirect_to @user
  	else
  		render :sign_up
  	end

  end
  def show
  	@user = User.find(params[:id])
  	render :profile
  end

  def update
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
