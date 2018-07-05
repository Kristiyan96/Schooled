# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'homeworks/show', type: :view do
  before(:each) do
    @homework = assign(:homework, Homework.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
