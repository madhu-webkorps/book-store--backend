class Users::UsersController < ApplicationController
  # load_and_authorize_resource
# def create 
#   @user = User.create(user_params)
#   if @user.valid?
#     token = encode_token({user_id: @user.id})
#     render json: {
#       user: @user ,
#       token: token 
#     } , status: :ok
#   else 
#     render json: {
#       errors: 'invalid username or password'
#     }, status: unprocessble entity
#   end
# end

# def login 
# @user = User.find_by(email: user_params[:email])
# if @user && @user.authenticate(user_params[:password])
#   token = encode_token({user_id: @user.id})
#   render json: {
#     user:@user,
#     token: token,
#     status: :ok
#   }
# end




    def index 
      user = User.all
      render json: user ,status:200
    end
    
    def update
      user = User.where(id: params[:id]).first
      if user.update(user_params)
        render json: user, status:200
      else
        render json: user.errors , status:422
      end
    end
  
    def destroy
      user = User.destroy(params[:id])
      render status:200
    end
    
    def get_admin
      admin = User.find_by(role: 1)
      render json: admin , status: 200
    end
  
    def user_params
      params.require(:user).permit(:name, :phone, :address, :email, :password, :role,:confirmPassword
      )
    end
  
  end