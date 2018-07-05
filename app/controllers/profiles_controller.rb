# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = (params[:id] && User.find(params[:id])) || current_user
    authorize @user

    @courses = @user.group.courses if @user.group_id
  end

  def schedule
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    @week_schedule = TimeSlot.schedule_table(current_user, @date)
    authorize current_user

    respond_to do |format|
      format.html {}
      format.js   { render action: '../schedules/week_schedule' }
    end
  end
end
