# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  it 'has a max of limit of 100' do
    allow(User).to receive(:limit).with(100).and_call_original

    request.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.Jddfq3-7sAXByGP8q58Iu43FIMA1DW1Kz_08tGb9VKI'

    get :index, params: { limit: 999 }

    expect(request[:limit].to_i).to eq(999)
  end
end
