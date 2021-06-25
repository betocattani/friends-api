# frozen_string_literal: true

module Api
  module V1
    class FriendshipSerializer < ActiveModel::Serializer
      attributes :user, :friend

      def user
        Api::V1::UserSerializer.new(object.user).as_json
      end

      def friend
        Api::V1::UserSerializer.new(object.friend).as_json
      end
    end
  end
end
