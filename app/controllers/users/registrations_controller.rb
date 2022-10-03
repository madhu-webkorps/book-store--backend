class Users::RegistrationsController < Devise::RegistrationsController
#  custom create
  def create
    debugger
    @user = User.new(sign_up_params)
    
    if @user.save!
      token = encode_user_data({ user_data: @user.id })
      render json: { message: 'Signed up sucessfully.',
      token: token,
      user: @user
    }

    #service for sending mail when user register...
     NewRegistrationService.new(user: @user).perform
     
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end 
  
end









