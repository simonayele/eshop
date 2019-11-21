class ChangeItemPriceToBeInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :price
    add_column :items, :price, :integer 
  end
end
