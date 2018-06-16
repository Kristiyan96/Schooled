class HomeworksController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_course
  before_action :set_homeworks, except: [:destroy]
  before_action :set_homework, only: [:update, :destroy]

  def index
    authorize @group, :show?
    @courses = @group.courses
  end

  def create
    @homework = @group.homeworks.new(homework_params)
    authorize @homework

    respond_to do |format|
      if @homework.save
        set_homeworks
        format.html { redirect_to @homework, notice: 'Homework was successfully created.' }
        format.json { render :show, status: :created, location: @homework }
        format.js { render action: "refresh_homeworks" }
      else
        format.html { render :new }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
        format.js { render action: "refresh_homeworks" }
      end
    end
  end

  def update
    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to @homework, notice: 'Homework was successfully updated.' }
        format.json { render :show, status: :ok, location: @homework }
        format.js { render action: "refresh_homeworks" }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
        format.js { render action: "refresh_homeworks" }
      end
    end
  end

  def destroy
    @homework.destroy
    @homeworks_past   = @group.homeworks.where('deadline < ?', DateTime.now)
    @homeworks_future = @group.homeworks.where('deadline > ?', DateTime.now)
    
    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'Homework was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render action: "refresh_homeworks" }
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
      authorize @homework
    end

    def set_homeworks
      @homeworks_past   = policy_scope(@group.homeworks.where('deadline < ?', DateTime.now))
      @homeworks_future = policy_scope(@group.homeworks.where('deadline > ?', DateTime.now))
    end

    def homework_params
      params.require(:homework).permit(:title, :description, :deadline, :course_id, :teacher_id)
    end
end
