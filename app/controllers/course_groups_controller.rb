class CourseGroupsController < ApplicationController
	before_action :set_course_group

  def show
  	@students = @course_group.group.students
  end

  private

  def set_course_group
  	@school = School.find(params[:school_id])
  	@course_group = CourseGroup.find(params[:id])
  end
end
