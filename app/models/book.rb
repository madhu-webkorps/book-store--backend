class Book < ApplicationRecord

    belongs_to :user

  # Validations
  validates :name, presence: true,
                        uniqueness: {case_sensitive: false},
                        length: {minimum: 4, maximum: 300}

  validates :author, presence: true,
                        length: {minimum: 4, maximum: 300}

  
  validates :user_id, presence: true

  validates :quantity, presence: true

  validates :edition, presence: true
end
