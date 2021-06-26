# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::FriendshipSerializer, type: :serializer do
  let(:friendship) { create(:friendship) }

  subject(:serializer) { described_class.new(friendship).as_json }

  it 'returns a user serialized' do
    expected_response = {
      "user": {
        "name": friendship.user.name,
        "email": friendship.user.email
      },
      "friend": {
        "name": friendship.friend.name,
        "email": friendship.friend.email
      }
    }

    expect(serializer).to eq(expected_response)
  end
end
