# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :invalid_request

  MAX_PAGINATION = 100

  private

  def respond_with_errors(object)
    render json: { status: 422, errors: serialize_errors(object) }, status: :unprocessable_entity
  end

  def invalid_request(error)
    render json: { status: 422, error: error.original_message }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    render json: { status: 404, error: exception.message }, status: :not_found
  end

  def serialize_errors(object)
    object.errors.messages.flat_map do |field, errors|
      errors.map do |error_message|
        { field: field.to_s, detail: error_message }
      end
    end
  end

  def authenticate_user
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)

    @current_user ||= User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    render json: { status: 401, error: 'Unauthorized' }, status: :unauthorized
  end

  def limit
    [params.fetch(:limit, MAX_PAGINATION).to_i, 100].min
  end
end
