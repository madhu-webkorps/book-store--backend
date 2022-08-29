class Users::RegistrationsController < Devise::RegistrationsController
 respond_to :json

     def create
      @user = User.new(sign_up_params)
      if @user.save
        token = @user.generate_jwt
        render json: { message: 'Signed up sucessfully.',
        token: token,
        user: @user
      }
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    end 
end









