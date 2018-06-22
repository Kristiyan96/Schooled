class AbsencesController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_year
  before_action :set_absence, only: [:update, :toggle_category]

  def create
    student_id = absence_params[:student_id]
    schedule_id = absence_params[:schedule_id]
    authorize Absence.new(student_id: student_id, schedule_id: schedule_id)

    respond_to do |format|
      if @absence = Absence
        .find_or_initialize_by(student_id: student_id, schedule_id: schedule_id)
        .update_attributes!(value: absence_params[:value])

        @absence = Absence.find_by(student_id: student_id, schedule_id: schedule_id)
        @absence.destroy! unless @absence.value > 0

        format.js   { }
      else
        format.html { render :new }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
        format.js   { }
      end
    end
  end

  def update
    authorize @absence

    respond_to do |format|
      if @absence.update(absence_params)
        format.html { redirect_to @absence, notice: 'Absence was successfully updated.' }
        format.json { render :show, status: :ok, location: @absence }
        format.js   { }
      else
        format.html { render :edit }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
        format.js   { }
      end
    end
  end

  def toggle_category
    authorize @absence
    if @absence.value == 1
      @absence.update(category: @absence.excused? ? 'permanent' : 'excused')
    end

    @student = @absence.student
    @date = @absence.schedule.time_slot.start.to_date

    respond_to do |format|
      format.js { }
    end
  end

  def excuse_period
    authorize @group, :update?
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    @schedules = @group.schedules.for_day(@date)
    @students = @group.students

    @student = User.find(params[:student_id])
    start = params[:start]
    finish = params[:end]

    Absence.excuse_period(@student, start, finish)

    respond_to do |format|
      format.js { render action: "refresh_card" }
    end
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_group
    @group = @school.groups.find(params[:group_id])
  end

  def set_year
    @year = @school.school_years.find_by_id(params[:school_year_id]) || @school.school_years.order(:year).last
  end

  def set_absence
    @absence = Absence.find(params[:id])
  end

  def absence_params
    params.require(:absence).permit(:student_id, :category, :schedule_id, :value, :student_id, :kind)
  end

  def value
    (params[:absence][:value]).to_r
  end
end
