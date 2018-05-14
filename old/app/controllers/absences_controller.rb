class AbsencesController < ApplicationController
  include AbsencesHelper
  before_action :set_absence, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @group            = current_user.hr_group
    @students         = @group.students
    @courses          = @group.courses.sort_by {|c| c.name }
    @course           = Course.find_by_id(params[:course_id]) || @courses.first
    @next_course      = next_course(@course, @courses)
    @next_next_course = next_course(@next_course, @courses)
  end

  def create
    @absence = Absence.new(absence_params)

    @student = @absence.student
    @course  = @absence.course

    respond_to do |format|
      if @absence.save
        format.js { render 'absence.js' }
      end
    end
  end

  def update
    @absence.excused   += absence_params[:excused].to_f
    @absence.excused    = validate_absence(@absence.excused)
    @absence.permanent += absence_params[:permanent].to_f
    @absence.permanent  = validate_absence(@absence.permanent)

    @student = @absence.student
    @course  = @absence.course

    respond_to do |format|
      if @absence.save
        format.js { render 'absence.js' }
      end
    end
  end

  private
    def set_absence
      @absence = Absence.find(params[:id])
    end

    def absence_params
      params.require(:absence).permit(:purpose, :user_id, :excused, :permanent, :course_id)
    end

    def next_course(current_course, relation)
      relation[relation.index(current_course)+1] || relation.first
    end
end
