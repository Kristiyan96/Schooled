class GroupsController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @groups = @school.groups
  end

  def show
    @school = School.find(params[:school_id])
    @group = @school.groups.find(params[:id])
  end
end
