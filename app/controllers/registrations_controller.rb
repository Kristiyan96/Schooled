# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :js

  private

  def sign_up_params
    params.require(:user).permit(:role, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :address, :phone_number, :birthday, :password, :password_confirmation, :current_password)
  end

  def update_resource(resource, params)
    if params[:current_password].blank?
      resource.update_without_password(params.except(:current_password))
    else
      resource.update_with_password(params)
    end
  end

  def after_update_path_for(resource)
    profile_path(resource)
  end
end
