
class Users::UsersController < ApplicationController
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