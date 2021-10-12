class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  #refileがカラム名にアクセスするためのもの、imageはカラム名だがidはつけない

end
