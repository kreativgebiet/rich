class AddTitleForHtml < ActiveRecord::Migration
  def change
    add_column :rich_rich_files, :title , :string
  end
end
