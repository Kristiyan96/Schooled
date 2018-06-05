require 'rails_helper'

RSpec.describe "absences/new", type: :view do
  before(:each) do
    assign(:absence, Absence.new())
  end

  it "renders new absence form" do
    render

    assert_select "form[action=?][method=?]", absences_path, "post" do
    end
  end
end
