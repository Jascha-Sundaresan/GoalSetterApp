class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
  end

  def show
    @goals = User.find(params[:id]).goals
    unless !@goals.empty? && current_user.id == @goals.first.user_id
      @goals = @goals.select { |goal| goal.public }
    end
    render :show
  end

  protected

  def user_params
    params.require(:user).permit(:name, :password)
  end

end
