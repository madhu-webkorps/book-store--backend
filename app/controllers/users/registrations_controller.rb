class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    # private
  
    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?
  
      register_failed
    end
  
    def register_success
      # Tell the UserMailer to send a welcome email after save
      # UserMailer.with(user: user).welcome_email.deliver_later
      render json: {
         message: 'Signed up sucessfully.',
        
     }
    end
  
    def register_failed
      render json: { message: "Something went wrong." }
    end
end