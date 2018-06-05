require 'rails_helper'

RSpec.describe "marks/edit", type: :view do
  before(:each) do
    @mark = assign(:mark, Mark.create!())
  end

  it "renders the edit mark form" do
    render

    assert_select "form[action=?][method=?]", mark_path(@mark), "post" do
    end
  end
end
