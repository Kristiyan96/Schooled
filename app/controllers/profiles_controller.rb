class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize @user

    if @user.group_id
      @courses = @user.group.courses
    end
  end

  def schedule
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    @week_schedule = TimeSlot.schedule_table(current_user, @date)
    authorize current_user

    respond_to do |format|
      format.html { }
      format.js   { render action: "../schedules/week_schedule" }
    end
  end
  
end
