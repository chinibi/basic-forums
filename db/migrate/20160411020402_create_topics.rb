class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.boolean :sticky
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
