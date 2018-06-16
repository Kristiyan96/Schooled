class TimeSlotsController < ApplicationController
  
  def show
    @school = School.find(params[:school_id])
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    @time_slots = policy_scope(TimeSlot.for_school(@school).for_day(@date))
    authorize @time_slots

    respond_to do |format|
      format.html { }
      format.js { render action: "refresh_card"}
    end
  end

  def create
    @school = School.find(params[:school_id])
    authorize TimeSlot.new(school: @school)
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    school_year = SchoolYear.find(time_slot_params[:school_year_id])

    TimeSlot.create_week_daily(school_year: school_year, date: @date, params: time_slot_params)

    @time_slots = policy_scope(TimeSlot.for_school(@school).for_day(@date))
    
    respond_to do |format|
      format.js { render action: "refresh_card"}
    end
  end

  def update
    time_slot = TimeSlot.find(params[:id])
    authorize time_slot
    #Type is one of [:one, :all]
    TimeSlot.update_with_type(time_slot: time_slot, type: type, params: update_slot_params)
    @school = time_slot.school
    @date = time_slot.start.to_date
    @time_slots = policy_scope(TimeSlot.for_school(@school).for_day(@date))

    respond_to do |format|
      format.js { render action: "refresh_card"}
    end
  end

  def destroy
    time_slot = TimeSlot.find(params[:id])
    authorize time_slot
    @school = time_slot.school
    @date = time_slot.start.to_date

    #Type is one of [:one, :all]
    TimeSlot.destroy_with_type(time_slot: time_slot, type: type)
    @time_slots = policy_scope(TimeSlot.for_school(@school).for_day(@date))

    respond_to do |format|
      format.js { render action: "refresh_card"}
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
