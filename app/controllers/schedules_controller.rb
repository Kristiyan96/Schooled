class SchedulesController < ApplicationController
  def show
    @school     = School.find(params[:school_id])
    @group      = @school.groups.find(params[:group_id])
    @date       = (params[:date] && Date.parse(params[:date])) || Date.today

    respond_to do |format|
      format.html { }
      format.js   { }
    end
  end

  def edit
    @school     = School.find(params[:school_id])
    @group      = @school.groups.find(params[:group_id])
    @courses    = @group.courses.to_a << Course::None
    @date       = (params[:date] && Date.parse(params[:date])) || Date.today
    @time_slots = @school.active_school_year.time_slots.for_day(@date)

    respond_to do |format|
      format.html { }
      format.js   { render action: "refresh_card"}
    end
  end

  def create
    @school     = School.find(params[:school_id])
    @group      = @school.groups.find(params[:group_id])
    @courses    = @group.courses.to_a << Course::None
    @date       = TimeSlot.find(schedule_params[:time_slot_id]).start
    @time_slots = @school.active_school_year.time_slots.for_day(@date)

    # NOTE(for Kris) Type param should be one of [:one, :series_7, :series_14]
    Schedule.create_with_type(school: @school, params: schedule_params)
    respond_to do |format|
      format.js { render action: "refresh_card"}
    end
  end

  def update
    @school     = School.find(params[:school_id])
    @group      = @school.groups.find(params[:group_id])
    @courses    = @group.courses.to_a << Course::None
    @schedule   = Schedule.find(params[:id])
    @date       = @schedule.time_slot.start
    @time_slots = @school.active_school_year.time_slots.for_day(@date)

    # Type param should be one of [:one, :series_7, :series_14]
    Schedule.update_with_type(school: @school, schedule: @schedule, params: update_params)
    respond_to do |format|
      format.js { render action: "refresh_card"}
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
