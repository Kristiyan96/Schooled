# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homeworks', type: :request do
  describe 'GET /homeworks' do
    it 'works! (now write some real specs)' do
      get homeworks_path
      expect(response).to have_http_status(200)
    end
  end
end
