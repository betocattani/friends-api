# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all

        render json: users
      end

      def create
        user = User.new(user_params)

        if user.save
          token = AuthenticationTokenService.call(user.id)

          render json: { token: token }, status: :created
        else
          respond_with_errors(user)
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
