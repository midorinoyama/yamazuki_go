class AddColumnsTo < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_image_id, :string
    add_column :users, :introduction, :text
    add_column :users, :gender, :integer, default: 0
    add_column :users, :age, :integer, default: 0
    add_column :users, :prefecture, :integer, default: 0
  end
end
