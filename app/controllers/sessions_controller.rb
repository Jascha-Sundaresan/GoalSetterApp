class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:name], params[:user][:password])
    if @user
      sign_in!(@user)
      redirect_to users_url
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end

end
