class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update]

  def index
    @school = School.find(params[:school_id])
    @groups = @school.groups
  end

  def show
  end

  def edit

  end

  def create
    @school = School.find(params[:school_id])
    @group = @school.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, notice: "There was an error while creating the group." }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, notice: "There was an error while creating the group." }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
  end

  private

  def set_group
    @school = School.find(params[:school_id])
    @group = School.groups.find(params[:id])
  end

  def group_params
    params.permit(:name, :grade, :teacher_id)
  end
end
