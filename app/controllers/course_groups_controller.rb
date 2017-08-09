class CourseGroupsController < ApplicationController
	before_action :set_course_group

  def show
  	@students = @course_group.group.students
  	@school = School.find(params[:school_id])
  end

  private

  def set_course_group
  	@course_group = CourseGroup.find(params[:id])
  end
end
