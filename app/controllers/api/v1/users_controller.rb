# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, only: :index

      def index
        users = User.all

        render json: users
      end
    end
  end
end
