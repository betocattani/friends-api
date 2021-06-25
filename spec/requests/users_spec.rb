# frozen_string_literal: true

require 'rails_helper'

describe 'Users API', type: :request do
  describe 'GET /users' do
    context 'when exist users and token is valid' do
      it 'returns a list of users' do
        create(:user, id: 1, email: 'user_one@mail.com')
        create(:user, id: 2, email: 'user_two@mail.com')

        get '/api/v1/users', headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.Jddfq3-7sAXByGP8q58Iu43FIMA1DW1Kz_08tGb9VKI' }

        response_parsed = JSON.parse(response.body).pluck('email')
        expect(response_parsed).to eq(['user_one@mail.com', 'user_two@mail.com'])

        expect(response).to have_http_status(:success)
      end
    end

    context 'when exist users and token is invalid' do
      it 'returns a list of users' do
        create(:user, id: 1, email: 'user_one@mail.com')
        create(:user, id: 2, email: 'user_two@mail.com')

        get '/api/v1/users', headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzAwMCJ9.7G4mkKBj5yGiFfnK4t0FXaTze8RvKk-NUsZaFnbwNQ0' }

        expect(JSON.parse(response.body)).to eq({ error: 'Unauthorized', status: 401 }.as_json)

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
