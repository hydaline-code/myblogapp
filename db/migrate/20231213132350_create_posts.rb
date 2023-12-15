class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :author, foreign_key: { to_table: :users, name: 'author_id' }
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.string :likes_counter

      t.timestamps
    end
    
  end
end
