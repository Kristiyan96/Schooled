class GroupsController < ApplicationController
  before_action :set_school
  before_action :set_group, except: [:index, :new, :create]

  def index
    @groups = policy_scope(@school.groups.order(:grade, :name))
  end

  def show
  end

  def new
    @group = @school.groups.new
    authorize @group
  end

  def edit
  end

  def create
    @group = @school.groups.new(group_params)
    authorize @group
    respond_to do |format|
      if @group.save
        format.html { redirect_to school_groups_path(@school), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, notice: "There was an error while creating the group." }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to school_group_path(@school, @group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, notice: "There was an error while creating the group." }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def week_schedule
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    @week_schedule = TimeSlot.schedule_table(@group, @date)
    
    respond_to do |format|
      format.html { }
      format.js   { render action: "../schedules/week_schedule"}
    end
  end

  def day_schedule
    @courses = @group.courses.to_a << Course::None
    @date = (params[:date] && Date.parse(params[:date])) || Date.today
    @time_slots = @school.active_school_year.time_slots.for_day(@date)

    respond_to do |format|
      format.html { }
      format.js   { render action: "../schedules/group_day_schedule"}
    end
  end

  def marks
    @courses = @group.courses.where(school_year: @school.active_school_year)
    @course = (params[:course_id] && Course.find(params[:course_id])) || @courses.first
    @mark = Mark.new
    respond_to do |format|
      format.html { }
      format.json { }
      format.js { }
    end
  end

  def absences

  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_group
    @group = @school.groups.find(params[:id])
    authorize @group
  end

  def group_params
    params.require(:group).permit(:name, :grade, :teacher_id)
  end
end
