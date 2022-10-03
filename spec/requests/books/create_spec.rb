require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
        let!(:book) { create(:book)} 
  debugger
        before do
          post '/book', params:
                            { book: {
                              
                              name: book.name,
                              author: book.author,
                              edition: book.edition,
                              quantity: book.quantity,

                            } }
        end
  
        
  
        it 'returns a created status' do
          expect(response).to have_http_status(:ok)
        end
      end
  end
end