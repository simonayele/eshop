class AlterItemsAddUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :user_id, :integer
    add_index :items, :user_id
  end
end
