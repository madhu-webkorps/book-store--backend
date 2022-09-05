class ChangeColumnToIssuedbook < ActiveRecord::Migration[6.1]
  def up
    change_column :issuedbooks, :is_returned, :boolean, default: false
    add_column :issuedbooks, :issued_on, :date
  end

   def down 
  
   end

end
