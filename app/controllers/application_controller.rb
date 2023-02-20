class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from JWT::DecodeError, with: :jwt_decode_error

  def record_not_found
    render json: { errors: 'Record not found' }, status: :not_found
  end

  def jwt_decode_error
    render json: { errors: 'Invalid token' }, status: :unauthorized
  end

  def authorize_request
    return unless decoded_token[:exp] < Time.now.to_i

    render json: { errors: 'Token has expired' }, status: :unauthorized
  end

  private

  def decoded_token
    return @decoded_token if @decoded_token

    token = extract_token_from_header
    @decoded_token = ::JsonWebTokenTool.decode(token)
  end

  def extract_token_from_header
    header = request.headers['Authorization']

    header&.split(' ')&.last
  end

  def current_user
    render json: { errors: 'User is unauthorized' }, status: :unauthorized if @decoded_token.nil?

    @current_user ||= User.find(@decoded_token[:user_id])
  end
end
