class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :location, :string
    add_column :users, :website, :string
    add_column :users, :bio, :string
  end
end
