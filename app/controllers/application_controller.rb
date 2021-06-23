# frozen_string_literal: true

class ApplicationController < ActionController::API
  def respond_with_errors(object)
    render json: { errors: serialize_errors(object) }, status: :unprocessable_entity
  end

  private

  def serialize_errors(object)
    object.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          status: 422,
          source: { parameter: field.to_s },
          detail: error_message
        }
      end
    end.flatten
  end
end
