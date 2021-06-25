# frozen_string_literal: true

require 'rails_helper'

describe 'Friendship', type: :request do
  describe 'POST /users/:email/friendship' do
    it 'creates a new friendship with valid token' do
      create(:user, id: 1, email: 'user_one@mail.com')
      friend = create(:user, id: 2, email: 'user_two@mail.com')

      post "/api/v1/users/#{friend.email}/friendship",
           headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.Jddfq3-7sAXByGP8q58Iu43FIMA1DW1Kz_08tGb9VKI' }

      expect(response).to have_http_status(:created)
      expect(response_body).to include('friendship')
    end

    it 'does not creates a new friendship with invalid token' do
      create(:user, id: 1, email: 'user_one@mail.com')
      friend = create(:user, id: 2, email: 'user_two@mail.com')

      post "/api/v1/users/#{friend.email}/friendship",
           headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzAwMCJ9.7G4mkKBj5yGiFfnK4t0FXaTze8RvKk-NUsZaFnbwNQ0' }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /users/me/friends' do
    context 'when exist friends and token is valid' do
      it 'returns a list of friends' do
        current_user = create(:user, id: 1, email: 'user_one@mail.com')
        friend = create(:user, id: 2, email: 'user_two@mail.com')

        Friendship.create(user_id: current_user.id, friend_id: friend.id)

        get '/api/v1/users/me/friends',
            headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.Jddfq3-7sAXByGP8q58Iu43FIMA1DW1Kz_08tGb9VKI' }

        expect(response).to have_http_status(:success)
        expect(response_body['friends'].first).to eq(
          {email: friend.email, name: friend.name }.as_json
        )
      end
    end
  end
end
