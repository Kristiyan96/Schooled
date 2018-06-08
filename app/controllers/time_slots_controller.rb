class TimeSlotsController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @date = Date.today
    @time_slots = TimeSlot.for_school(@school).for_day(@date)
  end

  def show
    @school = School.find(params[:school_id])
    @date = Date.parse(params[:date])
    @time_slots = TimeSlot.for_school(@school).for_day(@date)
    respond_to do |format|
      format.js { }
    end
  end

  def create
    @school = School.find(params[:school_id])
    @date = Date.parse(params[:date])
    school_year = SchoolYear.find(time_slot_params[:school_year_id])
    TimeSlot.create_week_daily(school_year: school_year, params: time_slot_params)
    @time_slots = TimeSlot.for_school(@school).for_day(@date)
    respond_to do |format|
      format.js { }
    end
  end

  def update
    time_slot = TimeSlot.find(params[:id])
    #Type is one of [:one, :all]
    TimeSlot.update_with_type(time_slot: time_slot, type: type, params: time_slot_params)
    @school = time_slot.school
    @date = time_slot.start.to_date
    @time_slots = TimeSlot.for_school(@school).for_day(@date)

    respond_to do |format|
      format.js { }
    end
  end

  def delete
    time_slot = TimeSlot.find(params[:id])

    #Type is one of [:one, :all]
    TimeSlot.destroy_with_type(time_slot: time_slot, type: type)

    respond_to do |format|
      format.js { }
    end
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:start, :end, :title, :school_year_id)
  end

  def type
    params[:type]
  end

  def update_slot_params
    params.require(:time_slot).permit(:start, :end, :title)
  end
end
