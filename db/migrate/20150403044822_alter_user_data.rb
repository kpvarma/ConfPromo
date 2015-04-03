class AlterUserData < ActiveRecord::Migration
  def change    # user_name is not required. we wil have email to act as user_name. instead we need name to be displayed
    rename_column :users, :user_name, :name
    change_column :users, :name, :text, null: false
    change_column :users, :email, :text, null: false

    # Removeing unnecessary columns
    remove_column :users, :organization, :string
    remove_column :users, :designation, :string

    ## Password Digest
    add_column :users, :password_digest, :string, :null => false
  end
end
