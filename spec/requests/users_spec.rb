# frozen_string_literal: true

require 'rails_helper'

describe 'Users API', type: :request do
  describe 'GET /users' do
    context 'when exist users and token is valid' do
      it 'returns a list of users' do
        create(:user, id: 1, email: 'user_one@mail.com')
        create(:user, id: 2, email: 'user_two@mail.com')

        get '/api/v1/users',
            headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.Jddfq3-7sAXByGP8q58Iu43FIMA1DW1Kz_08tGb9VKI' }

        expect(response_body['users'].pluck('email')).to eq(['user_one@mail.com', 'user_two@mail.com'])

        expect(response).to have_http_status(:success)
      end

      it 'retuns a subset of users based on limit' do
        create(:user, id: 1, email: 'user_one@mail.com')
        create(:user, id: 2, email: 'user_two@mail.com')

        get '/api/v1/users',
            headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.Jddfq3-7sAXByGP8q58Iu43FIMA1DW1Kz_08tGb9VKI' },
            params: { limit: 1 }

        expect(response_body.size).to eq(1)
        expect(response).to have_http_status(:success)
        expect(response_body['users'].pluck('email')).to eq(['user_one@mail.com'])
      end

      it 'retuns a subset of users based on limit and offset' do
        create(:user, id: 1, email: 'user_one@mail.com')
        create(:user, id: 2, email: 'user_two@mail.com')

        get '/api/v1/users',
            headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.Jddfq3-7sAXByGP8q58Iu43FIMA1DW1Kz_08tGb9VKI' },
            params: { limit: 1, offset: 1 }

        expect(response_body.size).to eq(1)
        expect(response).to have_http_status(:success)
        expect(response_body['users'].pluck('email')).to eq(['user_two@mail.com'])
      end
    end

    context 'when exist users and token is invalid' do
      it 'returns a list of users' do
        create(:user, id: 1, email: 'user_one@mail.com')
        create(:user, id: 2, email: 'user_two@mail.com')

        get '/api/v1/users',
            headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzAwMCJ9.7G4mkKBj5yGiFfnK4t0FXaTze8RvKk-NUsZaFnbwNQ0' }

        expect(response).to have_http_status(:unauthorized)
        expect(response_body['error']).to eq('Unauthorized')
        expect(response_body['status']).to eq(401)
      end
    end
  end
end
