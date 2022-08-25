class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :role, :integer , default: 0

    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
