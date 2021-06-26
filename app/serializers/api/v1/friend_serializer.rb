# frozen_string_literal: true

module Api
  module V1
    class FriendSerializer < ActiveModel::Serializer
      type :friend

      attributes :name, :email
    end
  end
end
