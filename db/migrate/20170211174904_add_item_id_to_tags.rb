class AddItemIdToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :item_id, :integer
  end
end
