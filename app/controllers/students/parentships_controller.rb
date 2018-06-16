class Students::ParentshipsController < ApplicationController
  
  def create
    @student = User.find(params[:student_id])
    authorize Parenship.new(student: @student, parent: User.new)
    @is_invited = Parentship.invite_parent(student: @student, parent: user_params)

    respond_to do |format|
      if @is_invited
        @user = User.find_by(email: user_params[:email])
        format.html { redirect_back fallback_location: profile_path(@student), notice: "Invited!" }
        format.js { render 'schools/parent_invitations/create' }
      else
        format.html { redirect_back fallback_location: profile_path(@student), alert: "Failed to invite!" }
        format.js { render 'schools/parent_invitations/create' }
      end
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name)
  end
end
