class RanksController < ApplicationController
  def rank
    @post_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    #P探す/いいねテーブルでpost_idごとにグループ分け/数が多いpost_idを並べる/最大5件表示/post_idカラムのみ取り出す
  end
end
