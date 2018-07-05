class ContactsController < ApplicationController

  def create
    skip_authorization
    @contact = Contact.new(contact_params)
    @contact.request = request

    respond_to do |format|
      if @contact.deliver
        format.js { }
      else
        format.js { }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

end
