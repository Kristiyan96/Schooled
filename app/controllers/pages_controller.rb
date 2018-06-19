class PagesController < ApplicationController
	def show
    skip_authorization
    if current_user
      if current_user.roles.any? && current_user.assignments.order(:created_at).first.role.name == "Headmaster"
        @school = current_user.assignments.order(:created_at).first.school
      end
    end

	  if valid_page?
	    render template: "pages/#{params[:page]}"
	  else
	    render file: "public/404.html", status: :not_found
	  end
	end

	private
	def valid_page?
	  File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.slim"))
	end
end
