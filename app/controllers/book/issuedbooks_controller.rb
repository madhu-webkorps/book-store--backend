
class Book::IssuedbooksController < ApplicationController
    # cancancan authorization

  before_action :authentication 
  # before_action load_and_authorize_resource , only: [:create]
  require 'stripe'
  Stripe.api_key =
  'sk_test_51LYBP3SDMv4dgdhUer8AFidk7ps2wzP90UWfDQtmzOQjYV9JgZW9mxQBHkPEqWlVs03iGGba36iMRSZtriRUmQaL00h22bVlg1'
  
 def index
    if signed_in?
       if @user.role == "admin" 
          @issuedbooks = Issuedbook.all
          if @issuedbooks.empty?
            render json: 
              {message:"No book has been issued"}
          else
          render json:
            {
            message: "Issuedbooks are",  
            issuedbooks: @issuedbooks}
          end
       elsif @user.role == "user"
          @issuedbooks = @user.issuedbooks
          if @issuedbooks.empty?
            render json: 
              {message:" You haven't issued any book "}
          else
            render json:
              {
              message: "you have this books",  
              issuedbooks: @user.issuedbooks}
          end
        else 
          render json:{
            message: "no record found"
          }
        end   
    else 
      render json: {message: "signed first"}
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
  
    if @user.admin? 
      render json: {
        message: "access deniend"
      }
    else
    @issuedbook = Issuedbook.new(issuedbook_params)
    
    # getting current user issued books
    books = @user.issuedbooks
    debugger
    
    array = []
    books.each do |book|
      if book.is_returned == false
        array << book.book_id
      end
    end
     

    if array.include?(@issuedbook.book.id)
      render json: {
        message:"you already have this book issued"}
    else
      if @issuedbook.book.quantity > 0
        @issuedbook.user = @user
        @issuedbook.issued_on = DateTime.now
        @issuedbook.return_dt = DateTime.now + 15.days
        @issuedbook.fine = 0
        if @issuedbook.save
          @issuedbook.book.update(id: @issuedbook.book.id)
          @issuedbook.book.user = @user

           render json: {book_issued: @issuedbook}, status: :created
        else
          render @issuedbook.errors
        end
      else
        render json:{
        message: "Sorry, This Book is not available for issuing."}
      end

    end 
    
   end
  end

    #update
  def update
    
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
            if @issuedbook.user == @user
              
              if @issuedbook.return_dt.day == DateTime.now.day
                @issuedbook.fine = 0
              else
                days =   (DateTime.now.to_i) - (@issuedbook.return_dt.to_i)
                late_days = (days/1.day).to_i
                 case late_days
                when 1..30
                  @issuedbook.fine = late_days * 7
                   
                when 30..60
                  @issuedbook.fine = late_days * 15
                   
                when 60..90
                  @issuedbook.fine = late_days * 25
                   
                 else
                  "pls return the book after today you have to pay fine"
                end
              end
              if @issuedbook.fine == 0
                  @issuedbook.destroy
                  @issuedbook.book.update(id: @issuedbook.book.id , quantity: @issuedbook.book.quantity + 1)
              # UserMailer.issue_return_create(@issuedbook).deliver_later
                  render json: {message: "Book was issued by you is return successfully"}, status: 200
              else
                render json: {
                  message: "frist pay fine",
                  fine: @issuedbook.fine
                }

              end

            else
              render json:{
                message:"This book is not issued by you."
               
              } 
              
            end

          
        end

        # def payFine
        #   @issuedbook = Issuedbook.find(params[:id])
           
        #   price = Stripe::Price.create({
        #   unit_amount: (@issuedbook.fine * 100).to_i,
        #   currency: 'inr',
        #   product: 'prod_MNmtnyq6vDcLg7'
        # })

        # order = Stripe::PaymentLink.create(
        #   line_items: [{price: price.id, quantity: 1}],
        #   after_completion: {type: 'redirect', redirect: {url: 'http://localhost:3001/UserIssuebook'}}
        #  )
        # end

        def payFine
       
          @issuedbook = Issuedbook.find(params[:id])
          @issuedbook.destroy!
          
        end
        
    private

    def set_issuedbook
      @issuedbook = Issuedbook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def issuedbook_params
      params.require(:issuedbook).permit(:user_id, :book_id, :is_returned, :issued_on, :return_dt, :submittion, :book_name)
    end

end
