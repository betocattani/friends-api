# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)

        if user.save
          render json: user, status: :created
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