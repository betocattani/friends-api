# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::FriendSerializer, type: :serializer do
  let(:user) { create(:user) }
  let!(:friendship) { create_list(:friendship, 3, user: user) }

  before do
    user.reload
  end

  subject(:serializer) do
    ActiveModelSerializers::SerializableResource.new(
      user.friends,
      each_serializer: Api::V1::FriendSerializer
    ).to_json
  end

  it 'returns a user serialized' do
    parsed_serializer = JSON.parse(serializer)

    expect(parsed_serializer['friends'].count).to eq(3)
    expect(parsed_serializer['friends'].first['name']).to eq(user.friends.first.name)
    expect(parsed_serializer['friends'].first['email']).to eq(user.friends.first.email)
  end
end
