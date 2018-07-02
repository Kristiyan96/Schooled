# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index

  def current_user
    @current_user ||= super && User.eager_load(:roles).find(@current_user.id)
  end
end
