class Book::BooksController < ApplicationController
  
  # cancancan authorization
  # load_and_authorize_resource
 

  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
    def index
      debugger
       books = Book.all
       render json: books, status: 200
    end
  

    # GET /books/1
    def show
      render json: @book , status:200
    end
  
    # POST /books

    def create
        book = Book.new(book_params)
        if book.save
          # User will get email confirmation after new book creation
          # UserMailer.new_book_creation(@book).deliver_later
          render json: {
            message: "Book was created sucessfully!" , 
            book: book ,
            status: :created
        }
        else
          render  book.errors
        end
    end
    
  
    # PATCH/PUT /books/1
    def update
      if @book.update(book_params)
        render json: { "message" => "book updated successfully", "book" => gen_book_data}
      else
        render json: @book.errors
    end
    end
  
    # DELETE /books/1
    def destroy
      if @book.destroy
        render json: {"message" => "Book deleted successfully with id: #{@book.id}, name: #{@book.name} "}
      else
       render json: {"message" =>"Book is not deleted"}
      end
    end
  
private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:name, :author, :edition, :quantity,:image)
  end
  end
  