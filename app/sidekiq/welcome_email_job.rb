class WelcomeEmailJob
  include Sidekiq::Job
  sidekiq_options tags: ['bank-ops', 'alpha']
  
  def perform(user_id)
    # Do something
    @user = User.find_by(id: user_id)
    UserMailer.welcome_email.deliver_now

  end
  Sidekiq.configure_server do |config|
    config.log_formatter = Sidekiq::Logger::Formatters::JSON.new
  end
end
