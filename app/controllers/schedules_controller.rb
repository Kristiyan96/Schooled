class SchedulesController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
    @date = Date.today
    @time_slots = TimeSlot.where(school_year: @school.school_years)
  end

  def show
    @school = School.find(params[:school_id])
    @date = Date.parse(params[:date])
    @group = @school.groups.find(params[:group_id])
    @schedules = @group.schedules.for_day(@date)
    respond_to do |format|
      format.js { }
    end
  end

  def create
    @school = School.find(params[:school_id])

    # NOTE(for Kris) Type param should be one of [:one, :series_7, :series_14]
    Schedule.create_with_type(school: @school, **schedule_params)
    respond_to do |format|
      format.js { }
    end
  end

  def update
    @school = School.find(params[:school_id])
    @schedule = Schedule.find(params[:id])

    # Type param should be one of [:one, :series_7, :series_14]
    Schedule.update_with_type(school: school, schedule: schedule, **update_params)
    respond_to do |format|
      format.js { }
    end
  end

  def destroy
    school = School.find(params[:id])
    schedule = Schedule.find(params[:id])

    # Type param should be one of [:one, :series_7, :series_14]
    Schedule.destroy_with_type(school: school, schedule: schedule, type: params[:schedules][:type])

    respond_to do |format|
      format.js { }
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:course_id, :time_slot_id, :type)
  end

  def update_params
    params.require(:schedule).permit(:course_id, :type)
  end
end
