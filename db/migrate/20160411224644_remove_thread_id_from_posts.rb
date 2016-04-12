class RemoveThreadIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :thread_id
  end
end
