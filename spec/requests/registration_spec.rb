# frozen_string_literal: true

require 'rails_helper'

describe 'Registration', type: :request do
  describe 'POST /signup' do
    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post '/api/v1/signup', params: {
            user: {
              email: 'test@axiomzen.co',
              name: 'Alex Zimmerman',
              password: 'axiomzen'
            }
          }
        }.to change(User, :count).from(0).to(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('token')
      end
    end

    context 'with invalid params' do
      it 'does not creates a new user and returns errors' do
        expect {
          post '/api/v1/signup', params: {
            user: {
              email: 'test@axiomzen',
              name: 'Alex Zimmerman'
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({
          errors: [
            {
              field: 'password',
              detail: "can't be blank"
            }
          ]
        }.as_json)
      end
    end
  end
end
