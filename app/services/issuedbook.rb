
  class  IssuedBook
    def self.is_book_has(book)

      array = []
      books.each do |book|
        if book.is_returned == false
          array << book.book_id
        end
      end
    return array

    end

end