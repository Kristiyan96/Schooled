class AbsencesController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_year
  before_action :set_absence, only: [:update, :destroy]

  def index
    @absence = Absence.new
    @date = Date.today
    @schedules = @group.schedules.for_day(@date)
    @school_year = @school.active_school_year
  end

  def new
    @absence = Absence.new
    @date = Date.today
    @schedules = @group.schedules.for_day(@date)
  end

  def show
    @date = Date.parse(params[:date])
    @schedules = @group.schedules.for_day(@date)
    respond_to do |format|
      format.js { render action: "refresh_card"}
    end
  end

  def create
    respond_to do |format|
      if @absence = Absence.create_multiple(absence_params)
        format.html { redirect_to @absence, notice: 'Absence was successfully created.' }
        format.json { render :show, status: :created, location: @absence }
        format.js { }
      else
        format.html { render :new }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
  end

  def update
    respond_to do |format|
      if @absence.update(absence_params)
        format.html { redirect_to @absence, notice: 'Absence was successfully updated.' }
        format.json { render :show, status: :ok, location: @absence }
        format.js { }
      else
        format.html { render :edit }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
        format.js { }
      end
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
    params.require(:absence).permit(:student_id, :category, :schedule_id, :value, student_ids: [])
  end

  def value
    (params[:absence][:value]).to_r
  end
end
