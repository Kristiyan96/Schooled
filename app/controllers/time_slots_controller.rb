class TimeSlotsController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @time_slots = TimeSlot.where(school_year: @school.school_years)
    @date = Date.today
  end

  def show
    school = School.find(params[:school_id])
    @date = Date.parse(params[:date])
    @time_slots = TimeSlot.for_school(school).for_day(@date)
    respond_to do |format|
      format.js { }
    end
  end

  def create
    TimeSlot.create_daily(**time_slot_params)
    respond_to do |format|
      format.js { }
    end
  end

  def update
    time_slot = TimeSlot.find(params[:id])

    #Type is one of [:one, :all]
    TimeSlot.update_with_type(time_slot: time_slot, type: type, params: time_slot_params)

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
