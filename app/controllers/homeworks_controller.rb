class HomeworksController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_course
  before_action :set_homework, only: [:show, :edit, :update, :destroy]

  def index
    @homeworks = Homework.all
  end

  def create
    @homework = Homework.new(homework_params)

    respond_to do |format|
      if @homework.save
        format.html { redirect_to @homework, notice: 'Homework was successfully created.' }
        format.json { render :show, status: :created, location: @homework }
        format.js { }
      else
        format.html { render :new }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
  end

  def update
    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to @homework, notice: 'Homework was successfully updated.' }
        format.json { render :show, status: :ok, location: @homework }
        format.js { }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
  end

  def destroy
    @homework.destroy
    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'Homework was successfully destroyed.' }
      format.json { head :no_content }
      format.js { }
    end
  end

  private

    def set_school
      @school = School.find(params[:school_id])
    end

    def set_group
      @group = @school.groups.find(params[:group_id])
    end

    def set_course
      @course = @group.courses.find_by_id(params[:course_id]) || @group.courses.first
    end

    def set_homework
      @homework = Homework.find(params[:id])
    end

    def homework_params
      params.fetch(:homework, {})
    end
end
