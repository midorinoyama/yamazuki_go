class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string  :image_id
      t.string  :title
      t.text    :content
      t.string  :mountain
      t.integer :prefecture, default: 0
      t.date    :filmed_on
      t.timestamps
    end
  end
end
