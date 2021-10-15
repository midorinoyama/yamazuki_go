class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  #validates_uniqueness_of :post_id, scope: :user_id
  #userは一つの投稿に対して、一つしかいいねできない設定
end
