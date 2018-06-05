class AbsencesController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_year
  before_action :set_absence, only: [:show, :edit, :update, :destroy]

  def index
    @absence = Absence.new
  end

  def create
    @absence = Absence.new(absence_params)

    respond_to do |format|
      if @absence.save
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
      params.require(:absence).permit(:student_id, :value, :kind, :category, :school_year_id)
    end
end
