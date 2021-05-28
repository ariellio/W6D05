class UsersController < ApplicationController

  def new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end


  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def index
    @users = User.all
    render :new
  end

   def user_params
        params.require(:user).permit(:username, :password)
    end

end