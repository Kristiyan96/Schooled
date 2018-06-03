class CoursesController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = @group.courses
  end

  def show
  end

  def new
    @course = @group.courses.new
  end

  def edit
  end

  def create
    @course = @group.courses.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
        format.js { }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
        format.js {}
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
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

    def set_course
      @course = @group.courses.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:teacher_id, :subject_id, :school_year_id, :school_id)
    end
end
