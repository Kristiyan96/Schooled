class ProfilesController < ApplicationController
  skip_authorization_check only: :show

  def index
    @school = School.find(params[:school_id])
    @group  = @school.groups.find(params[:group_id])
  end

  def show
    @user = User.find(params[:id])
  end
end
