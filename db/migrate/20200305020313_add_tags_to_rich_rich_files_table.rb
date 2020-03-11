class AddTagsToRichRichFilesTable < ActiveRecord::Migration[5.1]
  def change
    add_column :rich_rich_files, :tags, :string
  end
end
