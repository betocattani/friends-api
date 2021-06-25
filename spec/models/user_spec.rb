# frozen_string_literal: true

require 'rails_helper'

describe User do
  it 'is valid with name, email and password' do
    user = build(:user)

    expect(user).to be_valid
  end

  it 'is invalid without name' do
    user = build(:user, name: nil)

    user.valid?
    expect(user.errors['name']).to include("can't be blank")
  end

  it 'is invalid without email' do
    user = build(:user, email: nil)

    user.valid?
    expect(user.errors['email']).to include("can't be blank")
  end

  it 'is invalid without password' do
    user = build(:user, password: nil)

    user.valid?
    expect(user.errors['password']).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    create(:user, email: 'john.doe@mail.com')
    user = build(:user, email: 'john.doe@mail.com')

    user.valid?
    expect(user.errors['email']).to include('has already been taken')
  end

  context 'friends' do
    it 'user with friends' do
      user = create(:user)
      friend = create(:user)

      user.friendships.create(friend_id: friend.id)

      expect(user.friends).to include(friend)
    end

    it 'user without friends' do
      user = create(:user)

      expect(user.friends).to be_empty
    end
  end
end
