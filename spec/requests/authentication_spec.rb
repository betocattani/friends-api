# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /login' do
    it 'authenticates the client' do
      user = create(:user)

      post '/api/v1/login', params: { login: { email: user.email, password: user.password } }

      expect(response).to have_http_status(:created)

      token = AuthenticationTokenService.call(user.id)

      json = JSON.parse(response.body)

      expect(json['token']).to eq(token)
    end

    it 'returns error when email is missing' do
      user = create(:user)

      post '/api/v1/login', params: { login: { password: user.password } }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq(
        {
          "errors": [
            {
              "detail": 'Invalid username or password'
            }
          ]
        }.as_json
      )
    end

    it 'returns error when password is missing' do
      user = create(:user)
      post '/api/v1/login', params: { login: { email: user.email, password: nil } }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq(
        {
          "errors": [
            {
              "detail": 'Invalid username or password'
            }
          ]
        }.as_json
      )
    end
  end
end
