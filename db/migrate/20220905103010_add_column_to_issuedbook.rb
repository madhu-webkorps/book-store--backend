class AddColumnToIssuedbook < ActiveRecord::Migration[6.1]
  def change
    add_column :issuedbooks, :book_name, :string
    # add_column :issuedbooks, :string, :string
  end
end
