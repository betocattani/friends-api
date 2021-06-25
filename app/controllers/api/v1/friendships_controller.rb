# frozen_string_literal: true

module Api
  module V1
    class FriendshipsController < ApplicationController
      def create
        user = User.first
        friend = User.find_by(email: params[:email])

        friendship = Friendship.create(user_id: user.id, friend_id: friend.id)

        render json: { friendship: FriendshipSerializer.new(friendship).as_json }, status: :created
      end
    end
  end
end
