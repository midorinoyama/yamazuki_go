class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  #followerテーブル、followedテーブルは実在しない
  #class_nameモデル名で参照するテーブルの所属先を指定
end
