class UserMailer < ApplicationMailer
    default from: 'madhu@gwebkorps.com'

    def welcome_email
      @user = params[:user]
      @url  = 'http://localhost:3000/LoginForm'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end

    def issuedBook_mail
      @user = params[:user]
      # @url  = 'http://localhost:3000/LoginForm'
      mail(to: @user.email, subject: 'Book issued ')
    end
    
end
