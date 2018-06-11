class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= super && User.eager_load(:roles).find(@current_user.id)
  end
end
