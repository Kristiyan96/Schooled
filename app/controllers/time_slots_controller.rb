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
    @slot = TimeSlot.find(params[:id])

    @slot.update(update_slot_params)

    redirect_to root_path
  end

  def delete
    @slot = TimeSlot.find(params[:id])

    @slot.destroy

    redirect_to root_path
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:start, :end, :period_start, :period_end, :school_year_id)
  end

  def update_slot_params
    params.require(:time_slot).permit(:start, :end)
  end
end
