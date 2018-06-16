class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def schedule
    authorize current_user
    @date          = (params[:date] && Date.parse(params[:date])) || Date.today
    @week_schedule = TimeSlot.schedule_table(current_user, @date)
    respond_to do |format|
      format.html { }
      format.js   { }
    end
  end
end
