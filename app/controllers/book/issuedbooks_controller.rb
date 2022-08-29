class Book::IssuedbooksController < ApplicationController


      def index
        debugger
        if signed_in?
          user = User.find_by(id: @current_user_id)
        end
          if user
            @issuedbooks = Issuedbook.all
          else
            @issuedbooks = current_user.issuedbooks
          end

          if @issuedbooks.empty?
            render json: 
              {message:" You haven't issued any book "}
          else
           render json:
            {
            message: "you have this books",  
            issuedbooks: @issuedBooks}
          end
          
      end

      def show
        if current_user.admin?
          render json: @issuedbook, status:200

        elsif current_user.id == @issuedbook.user.id
          render json: @issuedbook, status:200
        else
          render json: {
            message:"The book you're trying to view is not issued by you" }
        end
      end

      def create
        debugger
        # only a student can issue a book
        @issuedbook = Issuedbook.new(issuedbook_params)
    
        # getting current user issued books
        # books = current_user.issuedbooks
        # array = []
        # books.each do |book|
        #   if book.is_returned == false
        #     array << book.book_id
        #   end
        # end
        
        # if array.include?(@issuedbook.book.id)
        #   render json: {
        #     message:"you already have this book issued"}
        # else

          if @issuedbook.book.quantity > 0
    
            @issuedbook.book.quantity -= 1 # decreasing the quatity of the book viz., issued
            @issuedbook.user = current_user
            @issuedbook.is_returned = false
            @issuedbook.issued_on = DateTime.now
            @issuedbook.fine = 20.00
    
            if @issuedbook.save
               @issuedbook.book.save
    
              # sending success issue mail to the user
              # UserMailer.issue_request_create(@issuedbook).deliver_later
              render json: {book_issued: gen_issued_book}, status: :created, location: @issuedbook
            else
              render @issuedbook.errors
            end
          else
            render json:{
            message: "Sorry, This Book is not available for issuing."}
          end
        # end
      end

    #update
  def update
    # Admin can't update a returned book
      if @issuedbook.is_returned == true
        render json:{
          message: "Cant't update, the book is already returned"}
      else
        if @issuedbook.update(issuedbook_params)
          render json: @issuedbook, status: 200
        else
          render @issuedbook.errors
        end
      end
  end
   
   # DELETE 
    def destroy
      if @issuedbook.destroy
        if @issuedbook.is_returned == false
          @issuedbook.book.quantity += 1 # after getting a active issue destroyed the book quantity will get increased by 1
          render json:{
            message: "IssuedBook-request deleted successfully with id: #{@issuedbook.id},
            issuer_name: #{@issuedbook.user.name}, "}
        else
          @issuedbook.book.save
          render json:{
            message: "IssuedBook-request deleted successfully with id: #{@issuedbook.id}, issuer_name: #{@issuedbook.user.name}"}
        end
      else
        render json:{
        message: "IssuedBook-request is not deleted"}
      end
    end

  # POST
        def return
          @issuedbook = Issuedbook.find(params[:id])
          # Checking whether the book is already returned or not
          if @issuedbook.is_returned == true
            render json: {
            message: "Book is already returned"
            }
          else
            if @issuedbook.user == current_user
              @issuedbook.return_dt = DateTime.now
              @issuedbook.book.quantity += 1 # after a successfull return the book quantity will be increased by 1
              @issuedbook.is_returned = true
              @issuedbook.save
              @issuedbook.book.save
              # UserMailer.issue_return_create(@issuedbook).deliver_later
            render json: @issuedbook, status: 200
            else
              render json:{
                message:"This book is not issued by you."

              } 
              
            end

          end
        end
        
    private

    def set_issuedbook
      @issuedbook = Issuedbook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def issuedbook_params
      params.require(:issuedbook).permit(:user_id, :book_id, :is_returned, :issued_on, :fine, :return_dt, :submittion)
    end

end
