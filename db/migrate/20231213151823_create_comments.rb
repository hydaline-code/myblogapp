class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false,foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
    add_index :comments, [:user_id, :post_id]
  end
end
