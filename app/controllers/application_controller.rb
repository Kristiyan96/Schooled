class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= super && User.eager_load(:roles).find(@current_user.id)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_path, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
end
