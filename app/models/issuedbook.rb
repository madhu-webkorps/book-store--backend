class Issuedbook < ApplicationRecord
     # Associations
     
    after_commit :issued_book_mail, on: :create 
    # before_destroy :increase_book_quantity
    after_create :decrease_book_quantity
    
     require 'date'
    
  belongs_to :book
  belongs_to :user

  # validations

  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :issued_on, presence: true
  
    def decrease_book_quantity
      
      book = Book.find_by(id: self.book.id)
      book.quantity -= 1
      book.update(id: book.id, quantity: book.quantity , user_id: self.user_id)
      puts 'quantity has been decrese'
    end

    def increase_book_quantity
      
      book = Book.find_by(id: self.book.id)
      book.quantity += 1
      book.update(id: book.id, quantity: book.quantity, user_id: self.user_id)
    end

# send mail to user for issuedbook
    def issued_book_mail
     
      @user = User.find(self.user_id)
      UserMailer.with(user: @user).issuedBook_mail.deliver_later
    end

  

end
