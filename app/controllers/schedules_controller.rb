class SchedulesController < ApplicationController
  before_action :set_school_and_group

  def show
    authorize current_user, :schedule?

    @schedule = Schedule.find(params[:id])
    @course = @schedule.course
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
  end

  def create
    @slot = TimeSlot.find(schedule_params[:time_slot_id])
    authorize @group, :update?

    @courses = @group.courses.to_a << Course::None
    @date = @slot.start

    @schedules = Schedule.create_with_type(school: @school, params: schedule_params)
    @time_slots = @school.active_school_year.time_slots.for_day(@date)
    @schedule = Schedule.find(@schedules.ids.first)

    respond_to do |format|
      format.js { }
    end
  end

  def update
    authorize @group, :update?
    
    @schedule = @group.schedules.find(params[:id])
    @slot = @schedule.time_slot
    @courses = @group.courses.to_a << Course::None
    @date = @schedule.time_slot.start
    @time_slots = @school.active_school_year.time_slots.for_day(@date)

    Schedule.update_with_type(school: @school, schedule: @schedule, params: update_params)

    respond_to do |format|
      format.js { }
    end
  end

  private

  def set_school_and_group
    @school = School.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
  end

  def schedule_params
    params.require(:schedule).permit(:course_id, :time_slot_id, :type)
  end

  def update_params
    params.require(:schedule).permit(:course_id, :type)
  end
end
