# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :invalid_request
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def respond_with_errors(object)
    render json: { errors: serialize_errors(object) }, status: :unprocessable_entity
  end

  private

  def invalid_request
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def record_not_found
    errors = { errors: [{ detail: 'user not found' }] }
    render json: errors, status: :not_found
  end

  def respond_unauthorized(message)
    errors = { errors: [{ detail: message }] }

    render json: errors, status: :unauthorized
  end

  def serialize_errors(object)
    object.errors.messages.map do |field, errors|
      errors.map do |error_message|
        { field: field.to_s, detail: error_message }
      end
    end.flatten
  end
end
