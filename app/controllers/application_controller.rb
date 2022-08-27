class ApplicationController < ActionController::API
   
    before_action :configure_permitted_parameters, if: :devise_controller?
    

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:address,:email,:password,:role_id,:phone , :password_confirmation
    ])
      end
end
