class AbsencesController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_absence, only: [:show, :edit, :update, :destroy]

  def index
    @absences = Absence.all
  end

  def show
  end

  def new
    @absence = Absence.new
  end

  def edit
  end

  def create
    @absence = Absence.new(absence_params)

    respond_to do |format|
      if @absence.save
        format.html { redirect_to @absence, notice: 'Absence was successfully created.' }
        format.json { render :show, status: :created, location: @absence }
      else
        format.html { render :new }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @absence.update(absence_params)
        format.html { redirect_to @absence, notice: 'Absence was successfully updated.' }
        format.json { render :show, status: :ok, location: @absence }
      else
        format.html { render :edit }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @absence.destroy
    respond_to do |format|
      format.html { redirect_to absences_url, notice: 'Absence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_school
      @school = School.find(params[:school_id])
    end

    def set_group
      @group = @school.groups.find(params[:group_id])
    end

    def set_absence
      @absence = Absence.find(params[:id])
    end

    def absence_params
      params.fetch(:absence, {})
    end
end
