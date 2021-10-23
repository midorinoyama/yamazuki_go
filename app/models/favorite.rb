class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :user_id
  #uniqueness: trueだと1投稿に1いいねしかできない(早い者勝ち)
  #scopeはuser_idで範囲指定(1ユーザーが1投稿に対して1いいね)
end
