class MarksController < ApplicationController
  before_action :set_student, except: [:index]
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
    @student = User.find(params[:user_id])
    @mark    = @student.marks.new(mark_params)
    @course  = Course.find(params[:mark][:course_id])

    respond_to do |format|
      if @mark.save
        format.html { redirect_to @coure, notice: 'Mark was successfully created.' }
        format.json { render :show, status: :created, location: @mark }
        format.js
      else
        format.html { render :new }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mark = Mark.find(mark_id)
    @course = @mark.course
    @purpose = @mark.purpose
    @mark.destroy
    respond_to do |format|
      format.html { redirect_to marks_url, notice: 'Mark was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def mark_id
      params.require(:id)
    end

    def set_student
      @student = User.find(params[:user_id])
    end

    def mark_params
      params.require(:mark).permit(:course_id, :mark, :purpose, :user_id)
    end

    def next_course(current_course, relation)
      relation[relation.index(current_course)+1] || relation.first
    end
end
