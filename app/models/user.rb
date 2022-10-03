class User < ApplicationRecord

#  after_commit :schedule_welcome_email, on: :create
 # devise
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

# enum for define role
  enum role: [:user , :admin]      
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end

# association  for book
  # has_many :books, dependent: :destroy
  has_many :issuedbooks, dependent: :destroy
 
  def generate_jwt
    JWT.encode({id: id, exp: 1.hours.from_now.to_i}, Rails.application.secrets.secret_key_base)
  end

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :email, presence: true,
            length: {minimum: 5, maxmimum: 105},
            uniqueness: {case_sensitive: false},
            format: { with: VALID_EMAIL_REGEX }

  validates :address, presence: true
            

  validates :name, presence: true,
            length: {minimum: 3}

  validates :password, presence: true,
            length: {minimum: 6, maximum: 20}

 
  
      def schedule_welcome_email
        UserMailer.with(user: self).welcome_email.deliver_later
      end
  
            
end

