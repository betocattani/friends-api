# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /login' do
    let(:user) { create(:user) }

    it 'returns an authenticated user' do
      post '/api/v1/login', params: { login: { email: user.email, password: user.password } }

      token = AuthenticationTokenService.call(user.id)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['token']).to eq(token)
    end

    it 'returns not_found when does not exist an user with the requested email' do
      post '/api/v1/login', params: { login: { email: 'non_existent@mail.com', password: user.password } }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq(
        {
          errors: [
            {
              detail: "Couldn't find User",
              status: 404
            }
          ]
        }.as_json
      )
    end

    it 'returns unauthorized when the password does not match' do
      post '/api/v1/login', params: { login: { email: user.email, password: 'wrong_password' } }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq(
        {
          errors: [
            {
              detail: 'Invalid username or password',
              status: 401
            }
          ]
        }.as_json
      )
    end
  end
end
