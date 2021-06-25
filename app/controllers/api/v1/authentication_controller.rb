# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from AuthenticationError, with: :handle_unauthenticated

      def create
        return unless validate_authentication_params
        raise AuthenticationError unless user.authenticate(authentication_params[:password])

        token = AuthenticationTokenService.call(user.id)

        render json: { token: token }, status: :created
      end

      private

      def user
        @user ||= User.find_by!(email: authentication_params[:email])
      end

      def handle_unauthenticated
        render json: { status: 401, error: 'Invalid password' }, status: :unauthorized
      end

      def validate_authentication_params
        authentication_params.fetch(:email) && authentication_params.fetch(:password)
      end

      def authentication_params
        params.require(:login).permit(:email, :password)
      end
    end
  end
end
