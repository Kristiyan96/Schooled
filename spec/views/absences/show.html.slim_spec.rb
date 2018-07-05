# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'absences/show', type: :view do
  before(:each) do
    @absence = assign(:absence, Absence.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
