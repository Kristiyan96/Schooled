require 'rails_helper'

RSpec.describe "absences/edit", type: :view do
  before(:each) do
    @absence = assign(:absence, Absence.create!())
  end

  it "renders the edit absence form" do
    render

    assert_select "form[action=?][method=?]", absence_path(@absence), "post" do
    end
  end
end
