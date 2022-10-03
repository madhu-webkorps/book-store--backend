class Book::BooksController < ApplicationController
  
  before_action :authentication 
  load_and_authorize_resource
  # cancancan authorization

  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
    def index
      
       books = Book.all
       render json: books, status: 200 
    end

    # GET /books/1
    def show
      render json: @book , status:200
    end

    # POST /books

    def create
        if @user.role == "admin" 
        book = Book.new(book_params)
          if book.save
            render json: {
              message: "Book was created sucessfully!" , 
              book: book ,
              status: :created
            }
          else
            render  book.errors
          end
        else 
          render json: {message: "access deniend"}
       end
    end

    # PATCH/PUT /books/1
    def update
      debugger
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
    debugger
    @book = Book.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:name, :author, :edition, :quantity,:image , :user_id)
  end
  end
  