# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /login' do
    it 'returns an authenticated user' do
      user = create(:user)
      post '/api/v1/login', params: { login: { email: user.email, password: user.password } }

      expect(response).to have_http_status(:created)
      expect(response_body).to include('token')
    end

    it 'returns error when email is missing' do
      post '/api/v1/login', params: { login: { password: 'Password1' } }

      expect(response).to have_http_status(:unprocessable_entity)

      expect(response_body['error']).to eq('param is missing or the value is empty: email')
    end

    it 'returns error when password is missing' do
      post '/api/v1/login', params: { login: { email: 'email@mail.com' } }

      expect(response).to have_http_status(:unprocessable_entity)

      expect(response_body['error']).to eq('param is missing or the value is empty: password')
    end

    it 'returns not_found when does not exist an user with the requested email' do
      user = create(:user)
      post '/api/v1/login', params: { login: { email: 'non_existent@mail.com', password: user.password } }

      expect(response).to have_http_status(:not_found)
      expect(response_body).to eq(
        {
          error: "Couldn't find User",
          status: 404
        }.as_json
      )
    end

    it 'returns unauthorized when the password does not match' do
      user = create(:user)
      post '/api/v1/login', params: { login: { email: user.email, password: 'wrong_password' } }

      expect(response).to have_http_status(:unauthorized)
      expect(response_body).to eq(
        { error: 'Invalid password', status: 401 }.as_json
      )
    end
  end
end
