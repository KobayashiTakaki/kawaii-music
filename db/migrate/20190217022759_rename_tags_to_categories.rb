class RenameTagsToCategories < ActiveRecord::Migration[5.2]
  def change
    rename_table :tags, :categories
  end
end
