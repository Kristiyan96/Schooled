class ProfilesController < ApplicationController

  def index
    @school = School.find(params[:school_id])
    @group  = @school.groups.find(params[:group_id])
  end

  def show
    @user = User.find(params[:id])
  end
end
