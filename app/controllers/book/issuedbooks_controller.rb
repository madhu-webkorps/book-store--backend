class Book::BooksController < ApplicationController
    def index
        if current_user.role.name == "admin"
          @issuedbooks = Issuedbook.all
        else
          @issuedbooks = current_user.issuedbooks
        end
        if @issuedbooks.empty?
          show_info({message:"there are no books to show"})
        else
          show_info({issuedbooks: gen_issued_book(many=true)})
        end
      end

      def show
        if current_user.role == "admin"
          show_info gen_issued_book
        elsif current_user.id == @issuedbook.user.id
          show_info gen_issued_book
        else
          faliure_response("The book you're trying to view is not issued by you")
        end
      end
    
end