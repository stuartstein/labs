class UsersController < ApplicationController
  
  def new
  	@user = User.new()
  end

  def show

  	@user = User.find(params[:id])

  end

  def create
  	
  	@user = User.new(get_account_params[:user])

  	if @user.save
  		create_session @user
  		redirect_to "profile/#{@user.id}"
  	else
  		render :new
  	end

  end

  def update
  end

  private
  def get_account_params
  	require(:user).permit(:name, :email, :password)
  end

end
