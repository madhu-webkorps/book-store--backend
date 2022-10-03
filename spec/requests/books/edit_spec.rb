require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'PATCH /update' do
    let!(:book) { create(:book)} 
    context 'with valid parameters' do
      
  
        before do
          id = book.id
          debugger
          patch "/book/#{id}" , params:
                            { 
                             
                              id: book.id,
                              name: book.name,
                              author: book.author,
                              edition: book.edition,
                              quantity: book.quantity

                             }
        end
  
        
  
        it 'returns a created status' do
          expect(response).to have_http_status(:ok)
        end
      end


  end
end