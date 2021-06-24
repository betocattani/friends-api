# frozen_string_literal: true

module Api
  module V1
    class RegistrationController < ApplicationController
      def create
        user = User.new(registration_params)

        if user.save
          token = AuthenticationTokenService.call(user.id)

          render json: { token: token }, status: :created
        else
          respond_with_errors(user)
        end
      end

      private

      def registration_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
