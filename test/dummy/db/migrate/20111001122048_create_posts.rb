class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.integer :image_id
      t.text :content

      t.timestamps
    end
  end
end
