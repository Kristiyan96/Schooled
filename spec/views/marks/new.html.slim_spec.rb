require 'rails_helper'

RSpec.describe "marks/new", type: :view do
  before(:each) do
    assign(:mark, Mark.new())
  end

  it "renders new mark form" do
    render

    assert_select "form[action=?][method=?]", marks_path, "post" do
    end
  end
end
