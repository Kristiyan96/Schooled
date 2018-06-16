class AbsencesController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_year
  before_action :set_absence, only: [:update, :destroy]

  def new
    @absence     = Absence.new
    @date        = (params[:date] && Date.parse(params[:date])) || Date.today
    @schedules   = @group.schedules.for_day(@date)
    @school_year = @school.active_school_year
    authorize @group, :teacher?

    respond_to do |format|
      format.html { }
      format.js   { render action: "refresh_card" }
    end
  end

  def show
    @date      = Date.parse(params[:date])
    @schedules = @group.schedules.for_day(@date)
    authorize @group, :teacher?
    
    respond_to do |format|
      format.js { render action: "refresh_card" }
    end
  end

  def create
    authorize Absence.new(absence_params.except(:student_ids))
    @date        = (params[:date] && Date.parse(params[:date])) || Date.today
    @schedules   = @group.schedules.for_day(@date)
    @school_year = @school.active_school_year

    respond_to do |format|
      if @absence = Absence.create_multiple(absence_params)
        format.html { redirect_to @absence, notice: 'Absence was successfully created.' }
        format.json { render :show, status: :created, location: @absence }
        format.js   { render action: "refresh_card" }
      else
        format.html { render :new }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
        format.js   { render action: "refresh_card" }
      end
    end
  end

  def update
    authorize Absence.new(absence_params.except(:student_ids))
    @date        = (params[:date] && Date.parse(params[:date])) || Date.today
    @schedules   = @group.schedules.for_day(@date)
    @school_year = @school.active_school_year

    respond_to do |format|
      if @absence.update(absence_params)
        format.html { redirect_to @absence, notice: 'Absence was successfully updated.' }
        format.json { render :show, status: :ok, location: @absence }
        format.js   { render action: "refresh_card" }
      else
        format.html { render :edit }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
        format.js   { render action: "refresh_card" }
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
    authorize @absence
  end

  def absence_params
    params.require(:absence).permit(:student_id, :category, :schedule_id, :value, student_ids: [])
  end

  def value
    (params[:absence][:value]).to_r
  end
end
