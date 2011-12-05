class RefactorImageToFile < ActiveRecord::Migration
  def change
    rename_table :rich_rich_images, :rich_rich_files

    rename_column :rich_rich_files, :image_file_name, :rich_file_file_name
    rename_column :rich_rich_files, :image_content_type, :rich_file_content_type
    rename_column :rich_rich_files, :image_file_size, :rich_file_file_size
    rename_column :rich_rich_files, :image_updated_at, :rich_file_updated_at

    add_column :rich_rich_files, :simplified_type, :string, :default => "file"
  end
end
