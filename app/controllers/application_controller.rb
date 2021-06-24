# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :invalid_request

  private

  def respond_with_errors(object)
    render json: { errors: serialize_errors(object) }, status: :unprocessable_entity
  end

  def invalid_request(error)
    render json: { status: 422, error: error.message }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    errors = { errors: [{ status: 404, detail: exception.message }] }
    render json: errors, status: :not_found
  end

  def serialize_errors(object)
    object.errors.messages.flat_map do |field, errors|
      errors.map do |error_message|
        { field: field.to_s, detail: error_message }
      end
    end
  end
end
