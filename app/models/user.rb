class User < ApplicationRecord

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

        enum role: [:user , :admin]
        after_initialize :set_default_role, :if => :new_record?
        def set_default_role
          self.role ||= :user
        end


        has_many :books, dependent: :destroy
        has_many :issuedbooks, dependent: :destroy

      # VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

      #   validates :email, presence: true,
      #                         length: {minimum: 5, maxmimum: 105},
      #                         uniqueness: {case_sensitive: false},
      #                         format: { with: VALID_EMAIL_REGEX }

      #   validates :address, presence: true,
      #                         length: {minimum: 7, maximum: 300}

      #   validates :name, presence: true,
      #                         length: {minimum: 3}

      #   validates :password, presence: true,
      #                         length: {minimum: 6, maximum: 20}

 
      after_commit :schedule_welcome_email, on: :create

      def schedule_welcome_email
        UserMailer.with(user: self).welcome_email.deliver_later
      end
  
            
end

