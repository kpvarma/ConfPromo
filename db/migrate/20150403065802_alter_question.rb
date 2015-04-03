class AlterQuestion < ActiveRecord::Migration
  def change

    rename_column :questions, :question, :title
    change_column :questions, :title, :text, null: false, limit: 256
    add_column :questions, :description, :string, :null => false, limit: 2048
    remove_column :questions, :answer_id

  end
end
