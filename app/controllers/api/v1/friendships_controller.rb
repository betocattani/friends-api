# frozen_string_literal: true

module Api
  module V1
    class FriendshipsController < ApplicationController
      before_action :authenticate_user, only: %I[create index]

      def index
        friends = @current_user.friends.limit(limit).offset(params[:offset])

        render json: friends, each_serializer: FriendSerializer
      end

      def create
        friend = User.find_by!(email: params[:email])

        friendship = Friendship.new(user_id: @current_user.id, friend_id: friend.id)

        if friendship.save
          render json: friendship, serializer: FriendshipSerializer, status: :created
        else
          respond_with_errors(friendship)
        end
      end
    end
  end
end
