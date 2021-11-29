class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post # ユーザーがいいねした投稿をuser.favorite_postsで呼び出し可能
  has_many :post_comments, dependent: :destroy
  attachment :profile_image
  # refileがカラム名にアクセスするためのもの、imageはカラム名だがidはつけない

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 外部キーの指定によりフォローする側から自分がフォローしている人取得
  has_many :followings, through: :relationships, source: :followed
  # 自分がフォローしている人一覧(throughでテーブル指定、sourceでrelationship.rbに記述したモデル指定)
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローされる側からフォローされている人取得
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自分をフォローしている人一覧

  validates :nickname, length: { maximum: 20, minimum: 2 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def follow(user_id) # フォローする
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id) # フォローを外す
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user) # フォローしていればtrueを返す
    followings.include?(user)
  end

  def self.search_for(content, method)
    User.where("nickname LIKE ?", "%" + content + "%")
  end

  enum gender: { "": 0, "男性": 1, "女性": 2 }, _prefix: true

  enum age: { "": 0, "10代": 1, "20代": 2, "30代": 3, "40代": 4, "50代": 5, "60代": 6, "70代以上": 70 }, _prefix: true

  enum prefecture: {
    "": 0,
    "北海道": 1, "青森県": 2, "岩手県": 3, "宮城県": 4, "秋田県": 5, "山形県": 6, "福島県": 7,
    "茨城県": 8, "栃木県": 9, "群馬県": 10, "埼玉県": 11, "千葉県": 12, "東京都": 13, "神奈川県": 14,
    "新潟県": 15, "富山県": 16, "石川県": 17, "福井県": 18, "山梨県": 19, "長野県": 20,
    "岐阜県": 21, "静岡県": 22, "愛知県": 23, "三重県": 24,
    "滋賀県": 25, "京都府": 26, "大阪府": 27, "兵庫県": 28, "奈良県": 29, "和歌山県": 30,
    "鳥取県": 31, "島根県": 32, "岡山県": 33, "広島県": 34, "山口県": 35,
    "徳島県": 36, "香川県": 37, "愛媛県": 38, "高知県": 39,
    "福岡県": 40, "佐賀県": 41, "長崎県": 42, "熊本県": 43, "大分県": 44, "宮崎県": 45, "鹿児島県": 46,
    "沖縄県": 47,
  }, _prefix: true
end
