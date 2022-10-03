class BookCreate
    attr_reader :name , :author , :edition , :quantity

    def initialize(name , author , edition , quantity)
        @name = name
        @author = author
        @edition = edition
        @quantity = quantity
      end

      def call 
        book = Book.new(book_params)
      end
end