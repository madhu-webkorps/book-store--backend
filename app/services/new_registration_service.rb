class NewRegistrationService
    def initialize(params)
      @user = params[:user]
    end
    def perform
      schedule_welcome_email
    end

    def encodeToken
      encode_user_data({ user_data: @user.id})
    end
  private
  
  def schedule_welcome_email
    UserMailer.with(user: @user).welcome_email.deliver_later
  end
end