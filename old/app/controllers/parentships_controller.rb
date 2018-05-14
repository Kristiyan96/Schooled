class ParentshipsController < ApplicationController
  def new; end

  def create
    student = User.find_by(identification: identification)
    current_user.students << student
    current_user.save!
  end

  private

  def identification
    params.require(:identification)
  end
end
