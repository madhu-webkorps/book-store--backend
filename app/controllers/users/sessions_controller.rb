class Users::SessionsController < Devise::SessionsController
  respond_to :json
  before_action :process_token, except: [:create]
  

def create
  @user = User.find_by_email(sign_in_params[:email])
  if @user && @user.valid_password?(sign_in_params[:password])
    token = @user.generate_jwt
    render json: { message: 'You are logged in.', user: @user, token: token}
  else
    render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  end
end

  
  def respond_to_on_destroy
    log_out_success && return if current_user
    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Hmm nothing happened."}, status: :unauthorized
  end
end




