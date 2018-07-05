# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'marks/show', type: :view do
  before(:each) do
    @mark = assign(:mark, Mark.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
