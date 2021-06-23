# frozen_string_literal: true

require 'rails_helper'

describe 'Users API', type: :request do
  describe 'POST /users' do
    context 'with valid params' do
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
    end

    context 'with invalid params' do
      it 'does not creates a new user and returns errors' do
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

  describe 'GET /users' do
    context 'when exist users' do
      it 'returns a list of users' do
        create(:user, email: 'user_one@mail.com')
        create(:user, email: 'user_two@mail.com')

        get '/api/v1/users'

        response_parsed = JSON.parse(response.body).pluck('email')
        expect(response_parsed).to eq(['user_one@mail.com', 'user_two@mail.com'])

        expect(response).to have_http_status(:success)
      end
    end

    context 'when does not exist users' do
      it 'returns a empty list' do
        get '/api/v1/users'

        response_parsed = JSON.parse(response.body)
        expect(response_parsed).to be_empty

        expect(response).to have_http_status(:success)
      end
    end
  end
end
