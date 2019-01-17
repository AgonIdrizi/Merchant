class RemoveColumnProducts < ActiveRecord::Migration[5.2]
  def change
  	remove_column :products, :price
  	add_column :products, :price_in_cents, :integer
  	add_column :products, :currency, :string
  end
end
