class TimeSlotsController < ApplicationController
  def show
    @school     = School.find(params[:school_id])
    authorize @school, :update?
    
    @date       = (params[:date] && Date.parse(params[:date])) || Date.today
    @time_slots = TimeSlot.for_school(@school).for_day(@date)

    respond_to do |format|
      format.html { }
      format.js { }
    end
  end

  def create
    @school = School.find(params[:school_id])
    authorize @school, :update?

    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    school_year = SchoolYear.find(time_slot_params[:school_year_id])

    @slots = TimeSlot.create_week_daily(school_year: school_year, date: @date, params: time_slot_params)
    @slot = TimeSlot.find(@slots.ids.first)
    
    respond_to do |format|
      format.js { }
    end
  end

  def update
    @slot = TimeSlot.find(params[:id])
    @school = @slot.school
    authorize @school, :update?

    TimeSlot.update_with_type(time_slot: @slot, type: params[:type], params: update_slot_params)
    @date = @slot.start.to_date

    respond_to do |format|
      format.js { }
    end
  end

  def destroy
    @slot = TimeSlot.find(params[:id])
    @school = @slot.school
    authorize @school, :update?

    @date = @slot.start.to_date
    TimeSlot.destroy_with_type(time_slot: @slot, type: params[:type])

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
