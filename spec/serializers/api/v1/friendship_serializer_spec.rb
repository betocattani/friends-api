# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::FriendshipSerializer, type: :serializer do
  let!(:user) { create(:user) }
  let!(:friendship) { create(:friendship, user: user) }

  subject(:serializer) do
    ActiveModelSerializers::SerializableResource.new(
      friendship,
      each_serializer: Api::V1::FriendshipSerializer
    ).to_json
  end

  it 'returns a friendship serialized' do
    expected_response = {
      "friendship": {
        "user": {
          "name": user.name,
          "email": user.email
        },
        "friend": {
          "name": friendship.friend.name,
          "email": friendship.friend.email
        }
      }
    }.as_json

    parsed_serializer = JSON.parse(serializer)

    expect(parsed_serializer).to include('friendship')
    expect(parsed_serializer['friendship']).to include('user')
    expect(parsed_serializer['friendship']).to include('friend')
    expect(parsed_serializer).to eq(expected_response)
  end
end
