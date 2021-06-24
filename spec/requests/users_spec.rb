# frozen_string_literal: true

require 'rails_helper'

describe 'Users API', type: :request do
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
