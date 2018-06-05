require 'rails_helper'

RSpec.describe "homeworks/edit", type: :view do
  before(:each) do
    @homework = assign(:homework, Homework.create!())
  end

  it "renders the edit homework form" do
    render

    assert_select "form[action=?][method=?]", homework_path(@homework), "post" do
    end
  end
end
