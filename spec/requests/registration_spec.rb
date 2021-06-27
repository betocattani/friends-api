# frozen_string_literal: true

require 'rails_helper'

describe 'Registration', type: :request do
  describe 'POST /signup' do
    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post '/signup', params: {
            user: {
              email: 'test@axiomzen.co',
              name: 'Alex Zimmerman',
              password: 'axiomzen'
            }
          }
        }.to change(User, :count).from(0).to(1)

        expect(response).to have_http_status(:created)
        expect(response_body).to include('token')
      end
    end

    context 'with invalid params' do
      it 'does not creates a new user and returns errors' do
        expect {
          post '/signup', params: {
            user: {
              email: 'test@axiomzen',
              name: 'Alex Zimmerman'
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['status']).to eq(422)

        response_body_errors = response_body['errors'].first

        expect(response_body_errors['field']).to eq('password')
        expect(response_body_errors['detail']).to eq("can't be blank")
      end
    end
  end
end
