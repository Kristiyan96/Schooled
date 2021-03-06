# frozen_string_literal: true

class SchoolsController < ApplicationController
  before_action :set_school, except: %i[index new]

  def index
    @schools = School.all
  end

  def show; end

  def dashboard; end

  def new
    @back_to_path = schools_path
    @school = School.new
  end

  def edit; end

  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_school
    @school = School.find(params[:id])
    authorize @school
  end

  def school_params
    params.require(:school).permit(:name, :contact_number, :address, :email, :number)
  end
end
