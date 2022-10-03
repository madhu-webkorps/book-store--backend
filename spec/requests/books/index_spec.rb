require 'rails_helper'
describe 'GET /books' , type: :request do
    let!(:book) { create_list :book , 5} 
    #let!(:book) { create :book }

    before do
      
      get('/book')
    end

it 'returns status success' do 
  expect(response).to have_http_status(:ok)
end



    it 'returns a list of books ' do 
      debugger
        expect(json).to eq(
          Book.all.map do |book|
            {
              id: book.id,
              name: book.name,
              author: book.author,
              edition: book.edition,
              quantity: book.quantity,
              created_at: book.created_at.utc.as_json,
              updated_at: book.updated_at.utc.as_json,
              user_id: nil
            }
          end

        )
    end
end 