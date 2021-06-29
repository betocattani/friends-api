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

  context 'scopes' do
    let(:another_friend) { create(:user) }

    let!(:friendship_created_by_the_user) { create(:friendship, user_id: user.id, friend_id: friend.id) }
    let!(:friendship_created_by_the_friend) { create(:friendship, user_id: another_friend.id, friend_id: user.id) }

    describe '#as_requester' do
      it 'returns a list of friend ids that the user added to his friend list' do
        friend_id_from_user_friendship_as_requester = described_class.as_requester(user.id)

        expect(friend_id_from_user_friendship_as_requester.count).to eq(1)
        expect(friend_id_from_user_friendship_as_requester.first).to eq(friend.id)
      end
    end

    describe '#as_requested' do
      it 'returns a list of ids of friends who have added the user to their friends list' do
        friend_id_from_friendship_as_requested = described_class.as_requested(user.id)

        expect(friend_id_from_friendship_as_requested.count).to eq(1)
        expect(friend_id_from_friendship_as_requested.first).to eq(another_friend.id)
      end
    end

    describe '#all_friends' do
      it 'returns a list of friend ids from all friendships the user is associated with' do
        all_friends = described_class.all_friends(user.id)

        expect(all_friends.count).to eq(2)
        expect(all_friends).to eq([friend.id, another_friend.id])
      end
    end
  end
end
