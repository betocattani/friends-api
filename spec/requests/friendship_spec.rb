# frozen_string_literal: true

require 'rails_helper'

describe 'Friendship', type: :request do
  describe 'POST /users/:email/friendship' do
    it 'creates a new friendship' do
      user = create(:user, id: 1)
      friend = create(:user, id: 2)

      post "/api/v1/users/#{friend.email}/friendship"

      expect(response).to have_http_status(:created)
      expect(response_body).to include('friendship')
    end
  end
end
