# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        user = User.find_by!(email: authentication_params[:email])

        if authenticate(user)
          token = AuthenticationTokenService.call(user.id)

          render json: { token: token }, status: :created
        else
          render json: { errors: [{ status: 401, detail: 'Invalid username or password' }] }, status: :unauthorized
        end
      end

      private

      def authenticate(user)
        user.authenticate(authentication_params[:password])
      end

      def authentication_params
        params.require(:login).permit(:email, :password)
      end
    end
  end
end
