class Book::BooksController < ApplicationController
  
  # GET /books
    def index
      books = Book.all
      render json: books
    end
  
    # GET /books/1
    def show
      
    end
  
    # POST /books
    def create
      @book = Book.new(book_params)
      if @book.save
        # User will get email confirmation after new book creation
        # UserMailer.new_book_creation(@book).deliver_later
        render json: {
           message: "Book was created sucessfully!" , 
           book: @book ,
          status: :created
      }
      else
        render  @book.errors
      end
    end
  
    # PATCH/PUT /books/1
    def update
      book = Book.where(id: params[:id]).first
      if book.update(book_params)
        render json: book, status:200
      else
        render json: book.errors , status:422
      end
    end
  
    # DELETE /books/1
    def destroy
      if @book.destroy
        success_response("Book deleted successfully with id: #{@book.id}, name: #{@book.name}, book_creator: #{@book.user.name}")
      else
        faliure_response("Book is not deleted")
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def book_params
        params.require(:book).permit(:name, :author, :edition, :quantity)
      end
  end
  