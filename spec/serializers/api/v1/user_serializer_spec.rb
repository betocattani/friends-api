# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UserSerializer, type: :serializer do
  let(:user) { create(:user) }

  subject(:serializer) { described_class.new(user).as_json }

  it 'returns a user serialized' do
    expect(serializer[:name]).to eq(user.name)
    expect(serializer[:email]).to eq(user.email)
  end
end
