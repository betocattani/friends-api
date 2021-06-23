# frozen_string_literal: true

require 'rails_helper'

describe 'Users API', type: :request do
  describe 'POST /users' do
    it 'creates a new user' do
      expect {
        post '/api/v1/users', params: {
          user: {
            email: 'test@axiomzen.co',
            name: 'Alex Zimmerman',
            password: 'axiomzen'
          }
        }
      }.to change(User, :count).from(0).to(1)

      expect(response).to have_http_status(:created)
    end

    it 'does not creates a new user with invalid params' do
      expect {
        post '/api/v1/users', params: {
          user: {
            email: 'test@axiomzen',
            name: 'Alex Zimmerman',
            password: nil
          }
        }
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
