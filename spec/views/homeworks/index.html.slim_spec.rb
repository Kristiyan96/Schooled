require 'rails_helper'

RSpec.describe "homeworks/index", type: :view do
  before(:each) do
    assign(:homeworks, [
      Homework.create!(),
      Homework.create!()
    ])
  end

  it "renders a list of homeworks" do
    render
  end
end
