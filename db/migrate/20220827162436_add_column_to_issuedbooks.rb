class AddColumnToIssuedbooks < ActiveRecord::Migration[6.1]
  def change
    add_column :issuedbooks, :fine, :float
    add_column :issuedbooks, :submittion, :datetime
  end
end
