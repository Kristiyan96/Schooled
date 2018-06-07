class SchedulesController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
    @date = Date.today
    @schedules = Schedule.where(course: @school.courses)
  end

  def create
    school = School.find(params[:school_id])

    # NOTE(for Kris) Type param should be one of [:one, :series_7, :series_14]
    Schedule.create_with_type(school: school, **schedule_params)

    redirect_to root_path
  end

  def update
    school = School.find(params[:id])
    schedule = Schedule.find(params[:id])

    # Type param should be one of [:one, :series_7, :series_14]
    Schedule.update_with_type(school: school, schedule: schedule, **update_params)

    redirect_to root_path
  end

  def destroy
    school = School.find(params[:id])
    schedule = Schedule.find(params[:id])

    # Type param should be one of [:one, :series_7, :series_14]
    Schedule.destroy_with_type(school: school, schedule: schedule, type: params[:schedules][:type])

    redirect_to root_path
  end

  private

  def schedule_params
    params.require(:schedules).permit(:course_id, :time_slot_id, :type)
  end

  def update_params
    params.require(:schedules).permit(:course_id, :type)
  end
end
