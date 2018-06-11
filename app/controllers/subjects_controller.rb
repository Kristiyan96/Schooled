class SubjectsController < ApplicationController
  before_action :set_school
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = @school.subjects.all
  end

  def new
    @subject = @school.subjects.new
  end

  def edit
  end

  def create
    @subject = @school.subjects.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.retuire(:subject).permit(:name)
  end
end
