class ApplicationController < ActionController::API
  before_action :validate_request

private

  class UnauthorizedAccess < StandardError; end

  def validate_request
    ip_address = request.env['REMOTE_ADDR']

    begin
      @api_token = ApiKey.active.find_by!(
        key: request.headers['X-Api-Key'],
        secret: request.headers['X-Api-Secret'],
        ip_address: ip_address
      )
    rescue ActiveRecord::RecordNotFound
      render json: {error: "Not Authorized"}, status: 401
    rescue => e
      render json: {error: "Forbidden Request"}, status: 403
    end
  end
end
