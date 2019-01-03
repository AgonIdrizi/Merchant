class AddCartIdToLineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :cart_id, :integer
    add_index :order_items, :cart_id
  end
end
