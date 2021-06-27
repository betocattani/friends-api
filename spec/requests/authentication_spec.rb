# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication', type: :request do
  let(:user) { create(:user) }

  describe 'POST /login' do
    it 'returns an authenticated user' do
      post '/login', params: { login: { email: user.email, password: user.password } }

      expect(response).to have_http_status(:created)
      expect(response_body).to include('token')
    end

    it 'returns error when email is missing' do
      post '/login', params: { login: { password: 'Password1' } }

      expect(response).to have_http_status(:unprocessable_entity)

      expect(response_body['error']).to eq('param is missing or the value is empty: email')
      expect(response_body['status']).to eq(422)
    end

    it 'returns error when password is missing' do
      post '/login', params: { login: { email: 'email@mail.com' } }

      expect(response).to have_http_status(:unprocessable_entity)

      expect(response_body['error']).to eq('param is missing or the value is empty: password')
      expect(response_body['status']).to eq(422)
    end

    it 'returns not_found when does not exist an user with the requested email' do
      post '/login', params: { login: { email: 'non_existent@mail.com', password: user.password } }

      expect(response).to have_http_status(:not_found)
      expect(response_body['error']).to eq("Couldn't find User")
      expect(response_body['status']).to eq(404)
    end

    it 'returns unauthorized when the password does not match' do
      post '/login', params: { login: { email: user.email, password: 'wrong_password' } }

      expect(response).to have_http_status(:unauthorized)
      expect(response_body['error']).to eq('Invalid password')
      expect(response_body['status']).to eq(401)
    end
  end
end
