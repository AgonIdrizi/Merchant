class FixAddresColumnNameInOrders < ActiveRecord::Migration[5.2]
  def change
  	rename_column :orders, :address_id, :billing_address_id
  end
end
