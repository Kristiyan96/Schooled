class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    case current_user.role
    when 'teacher'
      @courses = current_user.courses
    when 'student'
      @courses = current_user.group.courses
    end
  end

  def show
    @students = @course.group.students
    @courses = current_user.group.courses if current_user.student?
    @courses = current_user.courses if current_user.teacher?
  end

  def new
    @course = Course.new
  end

  def edit
    @school = School.find(params[:school_id])
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to school_course_path(@course), notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
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
    def set_course
      @course = Course.find_by_id(params[:course_id]) || Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:grade, :study_hours, :group_id, :user_id, :subject_id, :year, :room)
    end
end
