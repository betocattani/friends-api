# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  it 'creates a new friendship' do
    friendship = described_class.new(user_id: user.id, friend_id: friend.id)
    expect(friendship).to be_valid
  end

  it 'does not creates a friendship already existent' do
    described_class.create(user_id: user.id, friend_id: friend.id)

    friendship = described_class.new(user_id: user.id, friend_id: friend.id)

    expect(friendship).not_to be_valid
  end

  it 'does not creates a friendship without user_id' do
    friendship = described_class.new(user_id: nil, friend_id: friend.id)
    expect(friendship).not_to be_valid
  end

  it 'does not creates a friendship without friend_id' do
    friendship = described_class.new(user_id: user.id, friend_id: nil)
    expect(friendship).not_to be_valid
  end

  it 'returns the user requester of the friendship' do
    friendship = described_class.create(user_id: user.id, friend_id: friend.id)

    expect(friendship.user).to eq(user)
  end

  it 'returns the user friend invited to the friendship' do
    friendship = described_class.create(user_id: user.id, friend_id: friend.id)

    expect(friendship.friend).to eq(friend)
  end
end
