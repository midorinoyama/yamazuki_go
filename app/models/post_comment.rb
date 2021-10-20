class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  belongs_to :parent, class_name: "PostComment", optional: true
  #parent:返信対象（1）のコメントid、親コメントに複数の返信をする
  #optional:trueはnilを許可して返信ではない新規コメントを保存できるように（リレーションを組むと返信コメントがないと保存できない状態）
  has_many :replies, class_name: "PostComment", foreign_key: :parent_id, dependent: :destroy
  #replies:返信されたコメント（多）
  validates :comment, presence: true#空白でコメントできないように制限
end
