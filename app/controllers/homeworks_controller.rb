# frozen_string_literal: true

class HomeworksController < ApplicationController
  before_action :set_school
  before_action :set_group
  before_action :set_course
  before_action :set_homework, only: %i[show edit update destroy]

  def index
    @courses          = @group.courses.where(teacher: current_user)
    @homeworks_past   = policy_scope(@group.homeworks.where('deadline < ?', DateTime.now))
    @homeworks_future = policy_scope(@group.homeworks.where('deadline > ?', DateTime.now))
  end

  def create
    @homework         = @group.homeworks.new(homework_params)
    authorize @homework

    @homeworks_past   = @group.homeworks.where('deadline < ?', DateTime.now)
    @homeworks_future = @group.homeworks.where('deadline > ?', DateTime.now)
    @homeworks = @group.homeworks.where(course: @course).order(:created_at)

    respond_to do |format|
      if @homework.save
        format.html { redirect_to @homework, notice: 'Homework was successfully created.' }
        format.json { render :show, status: :created, location: @homework }
        format.js { render action: 'refresh_homeworks' }
      else
        format.html { render :new }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
        format.js { render action: 'refresh_homeworks' }
      end
    end
  end

  def update
    @homeworks = @group.homeworks
    authorize @homework

    @homeworks_past   = @group.homeworks.where('deadline < ?', DateTime.now)
    @homeworks_future = @group.homeworks.where('deadline > ?', DateTime.now)
    @homeworks = @group.homeworks.where(course: @course).order(:created_at)

    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to @homework, notice: 'Homework was successfully updated.' }
        format.json { render :show, status: :ok, location: @homework }
        format.js { render action: 'refresh_homeworks' }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
        format.js { render action: 'refresh_homeworks' }
      end
    end
  end

  def destroy
    authorize @homework

    @homework.destroy
    @homeworks_past   = @group.homeworks.where('deadline < ?', DateTime.now)
    @homeworks_future = @group.homeworks.where('deadline > ?', DateTime.now)
    @homeworks = @group.homeworks.where(course: @course).order(:created_at)

    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'Homework was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render action: 'refresh_homeworks' }
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
    params.require(:homework).permit(:title, :description, :deadline, :course_id, :teacher_id)
  end
end
