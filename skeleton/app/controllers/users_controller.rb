class UsersController < ApplicationController

  def new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user)
    else
      render :new
    end
  end


end