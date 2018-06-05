require 'rails_helper'

RSpec.describe "marks/index", type: :view do
  before(:each) do
    assign(:marks, [
      Mark.create!(),
      Mark.create!()
    ])
  end

  it "renders a list of marks" do
    render
  end
end
