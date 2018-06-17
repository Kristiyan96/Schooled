class SchedulesController < ApplicationController
  def show
    @school        = School.find(params[:school_id])
    @group         = @school.groups.find(params[:group_id])
    @date          = (params[:date] && Date.parse(params[:date])) || Date.today
    @week_schedule = TimeSlot.schedule_table_for_group(@group, @date)
    
    respond_to do |format|
      format.html { }
      format.js   { }
    end
  end

  def edit
    @school = School.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
    @courses = @group.courses.to_a << Course::None
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    @time_slots = @school.active_school_year.time_slots.for_day(@date)

    respond_to do |format|
      format.html { }
      format.js   { render action: "refresh_card"}
    end
  end

  def create
    @slot = TimeSlot.find(schedule_params[:time_slot_id])
    @school = School.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
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
    @school     = School.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
    @courses = @group.courses.to_a << Course::None
    @date       = @schedule.time_slot.start
    @time_slots = @school.active_school_year.time_slots.for_day(@date)

    schedule = Schedule.find(params[:id])
    Schedule.update_with_type(school: @school, schedule: schedule, params: update_params)

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
