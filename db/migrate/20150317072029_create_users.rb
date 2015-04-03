class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :organization
      t.string :designation
      t.timestamps null: false
    end
  end
end
