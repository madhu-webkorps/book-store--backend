class ApplicationController < ActionController::API
  
  before_action :configure_permitted_parameters, if: :devise_controller?
    
  SECRET = Rails.application.secrets.secret_key_base
 
  def authentication

    if request.headers['Authorization'].present?
      begin
      
        decode_data = decode_user_data(request.headers['Authorization'])
        @user = User.find(decode_data[0]['user_data'])
        @current_user_id = @user.id
     rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        render json: {message: "token expired"}, status: :unauthorized
      end
    end

    if @user
      return @user
    else
      render json: { message: "invalid credentials" }
    end

  end

  # custom current user method
  # def current_user
  #   @current_user ||= super || User.find(@current_user_id)
  # end

  # user signed in method
  def signed_in?
    @current_user_id.present?
  end

  # encode token
  def encode_user_data(payload)
    token = JWT.encode payload, SECRET, "HS256"
    return token
  end

  

  # decode token 
  def decode_user_data(token)
    begin
      data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end


  # devise permit parameters
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user|
          user.permit(:email, :name, :password, :role, :password_confirmation , :phone , :address)
        end
    end

# can can can eroors
    rescue_from CanCan::AccessDenied do |exception|
      render json:
       { message: "you havn,t access",
          status: :unauthorized 
        }
      end

    rescue_from ActionController::ParameterMissing do |e|
      render 'parameter missing'
    end

    


end