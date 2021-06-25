# frozen_string_literal: true

module Api
  module V1
    class FriendshipsController < ApplicationController
      before_action :authenticate_user, only: :create

      def create
        friend = User.find_by(email: params[:email])

        friendship = Friendship.new(user_id: @current_user.id, friend_id: friend.id)

        if friendship.save
          render json: { friendship: FriendshipSerializer.new(friendship).as_json }, status: :created
        else
          respond_with_errors(friendship)
        end
      end
    end
  end
end
