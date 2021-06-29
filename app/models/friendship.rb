# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, :friend_id, presence: true
  validates :user_id, uniqueness: { scope: :friend_id }

  scope :as_requester, ->(id) { where(user_id: id).pluck(:friend_id) }
  scope :as_requested, ->(id) { where(friend_id: id).pluck(:user_id) }
  scope :all_friends, ->(id) { as_requester(id) + as_requested(id) }
end
