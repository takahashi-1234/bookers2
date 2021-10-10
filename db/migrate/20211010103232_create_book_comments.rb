class CreateBookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :book_comments do |t|
      t.string :user_id
      t.string :book_id
      t.text :comment

      t.timestamps
    end
  end
end
