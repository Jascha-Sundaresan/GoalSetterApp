class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.try(:destroy)

    redirect_to user_url(goal.user_id)
  end

  def toggle_privacy
    goal = Goal.find(params[:id])
    goal.public = !goal.public
    goal.save!
    redirect_to user_url(goal.user_id)
  end

  def toggle_completion
    goal = Goal.find(params[:id])
    goal.complete = !goal.complete
    goal.save!
    redirect_to user_url(goal.user_id)
  end

  protected

  def goal_params
    params.require(:goal).permit(:title, :description)
  end

end
