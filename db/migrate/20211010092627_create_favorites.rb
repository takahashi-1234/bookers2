class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string:user_id
      t.string:book_id
      t.timestamps
    end
  end
end
