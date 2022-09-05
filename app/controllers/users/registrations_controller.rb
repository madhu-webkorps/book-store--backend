class Users::RegistrationsController < Devise::RegistrationsController
#  custom create
  def create
    @user = User.new(sign_up_params)
    
    if @user.save!
      token = encode_user_data({ user_data: @user.id })
      render json: { message: 'Signed up sucessfully.',
      token: token,
      user: @user
    }
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end 
  
end









