class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :image_id
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :mountain
      t.string :prefecture
      t.date :filmed_on

      t.timestamps
    end
  end
end
