class Users::SessionsController < Devise::SessionsController

  #custom create method methode 
  def create
  
    @user = User.find_by_email(sign_in_params[:email])
    if @user && @user.valid_password?(sign_in_params[:password])
     token = encode_user_data({ user_data: @user.id })
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




