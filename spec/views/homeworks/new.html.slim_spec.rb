require 'rails_helper'

RSpec.describe "homeworks/new", type: :view do
  before(:each) do
    assign(:homework, Homework.new())
  end

  it "renders new homework form" do
    render

    assert_select "form[action=?][method=?]", homeworks_path, "post" do
    end
  end
end
