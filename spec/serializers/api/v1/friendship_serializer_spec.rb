# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::FriendshipSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  let(:friendship) { Friendship.create(user_id: user.id, friend_id: friend.id) }

  subject(:serializer) { described_class.new(friendship).as_json }

  it 'returns a user serialized' do
    expected_response = {
      "user": {
        "name": user.name,
        "email": user.email
      },
      "friend": {
        "name": friend.name,
        "email": friend.email
      }
    }

    expect(serializer).to eq(expected_response)
  end
end
