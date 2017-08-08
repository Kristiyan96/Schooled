class MarksController < ApplicationController
  before_action :set_mark, only: [:destroy]
  before_action :set_student

  def create
    @mark = User.find(params[:user_id]).marks.new(mark_params)
    @course_group = CourseGroup.find(params[:mark][:course_group_id])
    respond_to do |format|
      if @mark.save
        format.html { redirect_to @coure_group, notice: 'Mark was successfully created.' }
        format.json { render :show, status: :created, location: @mark }
        format.js
      else
        format.html { render :new }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mark.destroy
    respond_to do |format|
      format.html { redirect_to marks_url, notice: 'Mark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_mark
      @mark = Mark.find(params[:id])
    end

    def set_student
      @student = User.find(params[:user_id])
    end

    def mark_params
      params.require(:mark).permit(:course_id, :user_id, :mark)
    end
end
