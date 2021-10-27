class RemoveParentIdInPostComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_comments, :parent_id, :integer
  end
end
