# frozen_string_literal: true

module Api
  module V1
    class FriendsSerializer < ActiveModel::Serializer
      attributes :name, :email
    end
  end
end
