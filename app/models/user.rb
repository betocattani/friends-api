# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :friendships
  has_many :friends, through: :friendships

  def friends
    friends_ids = Friendship.all_friends(id)

    User.where(id: friends_ids)
  end
end
