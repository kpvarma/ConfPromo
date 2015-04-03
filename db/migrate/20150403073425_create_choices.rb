class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :text, limit: 512
      t.boolean :answer, default: false
      t.references :question, index: true
      t.timestamps null: false
    end
    add_foreign_key :choices, :questions
  end
end
