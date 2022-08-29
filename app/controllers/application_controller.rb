class ApplicationController < ActionController::API
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :process_token, except: [:create]
  
protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
        user.permit(:email, :name, :password, :role, :password_confirmation)
      end
  end
#   private
#   # Check for auth headers - if present, decode or send unauthorized response (called always to allow current_user)
    def process_token
     
      if request.headers['Authorization'].present?
        begin
          jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.secrets.secret_key_base).first
          @current_user_id = jwt_payload['id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          render json: {message: "token expired"}, status: :unauthorized
        end
      end
    end

  # If user has not signed in, return unauthorized response (called only when auth is needed)
  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

    #   set Devise's current_user using decoded JWT instead of session
    def current_user
      debugger
      @current_user ||= super || User.find(@current_user_id)
    end

  # check that authenticate_user has successfully returned @current_user_id (user is authenticated)
  def signed_in?
    @current_user_id.present?
  end
end
