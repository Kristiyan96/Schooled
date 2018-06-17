class ProfilesController < ApplicationController

  def index
    @school = School.find(params[:school_id])
    @group  = @school.groups.find(params[:group_id])
  end

  def dashboard

  end

  def schedule
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    @week_schedule = TimeSlot.schedule_table(current_user, @date)

    respond_to do |format|
      format.html { }
      format.js   { render action: "../schedules/index" }
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
