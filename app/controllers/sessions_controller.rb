class SessionsController < ApplicationController
  def new
  end

  def create
    user = model.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def model
		byebug
    if Authentication.inclusions.include?(params[:session][:type])
      params[:session][:type].constantize
    else
      raise 'Error - unpermitted type.'
    end
  end
end
