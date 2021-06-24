# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        user = User.find_by(email: authentication_params[:email])

        if user && authenticate(user)
          token = AuthenticationTokenService.call(user.id)

          render json: { token: token }, status: :created
        else
          respond_unauthorized('Invalid username or password')
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
