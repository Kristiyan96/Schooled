class Schools::GroupsController < ApplicationController
  def index
    @groups = Group.where(school_id: params[:school_id])
  end
end
