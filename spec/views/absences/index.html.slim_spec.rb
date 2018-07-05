# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'absences/index', type: :view do
  before(:each) do
    assign(:absences, [
             Absence.create!,
             Absence.create!
           ])
  end

  it 'renders a list of absences' do
    render
  end
end
