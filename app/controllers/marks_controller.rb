class MarksController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_year
  before_action :set_course
  before_action :set_mark, only: [:update, :destroy]

  def index
    @courses = @group.courses.where(school_year: @school.active_school_year)
    @mark = Mark.new
    respond_to do |format|
      format.html { }
      format.json { }
      format.js { }
    end
  end

  def create
    @mark = Mark.new(mark_params)
    respond_to do |format|
      if @mark.save
        format.html { redirect_to school_group_marks_path(@school, @group, course_id: @course.id), notice: 'Mark was successfully created.' }
        format.json { render :show, status: :created, location: @mark }
        format.js { }
      else
        format.html { render :new }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
  end

  def update
    respond_to do |format|
      if @mark.update(mark_params)
        format.html { redirect_to @mark, notice: 'Mark was successfully updated.' }
        format.json { render :show, status: :ok, location: @mark }
        format.js { }
      else
        format.html { render :edit }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
  end

  def destroy
    @mark.destroy
    respond_to do |format|
      format.html { redirect_to marks_url, notice: 'Mark was successfully destroyed.' }
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

    def set_year
      @year = @school.school_years.find_by_id(params[:school_year_id])
    end

    def set_course
      @course = @group.courses.find_by_id(params[:course_id]) || @group.courses.first
    end

    def set_mark
      @mark = Mark.find(params[:id])
    end

    def mark_params
      params.require(:mark).permit(:student_id, :grade, :course_id, :kind)
    end
end
