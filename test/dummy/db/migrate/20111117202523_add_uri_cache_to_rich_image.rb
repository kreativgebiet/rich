class AddUriCacheToRichImage < ActiveRecord::Migration
  def change
    add_column :rich_rich_images, :uri_cache, :text
  end
end
