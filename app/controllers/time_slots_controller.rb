class TimeSlotsController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @group = Group.find(params[:group_id])

    @time_slots = TimeSlot.where(school_year: @school.school_years)
  end

  def create
    TimeSlot.create_daily(**time_slot_params)
  end

  def update
    time_slot = TimeSlot.find(params[:id])

    #Type is one of [:one, :all]
    TimeSlot.update_with_type(time_slot: time_slot, type: type, params: time_slot_params)

    redirect_to root_path
  end

  def delete
    time_slot = TimeSlot.find(params[:id])

    #Type is one of [:one, :all]
    TimeSlot.destroy_with_type(time_slot: time_slot, type: type)

    redirect_to root_path
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:start, :end, :school_year_id)
  end

  def type
    params[:type]
  end
end
