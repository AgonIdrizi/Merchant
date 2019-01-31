class AddOrderIdToCharges < ActiveRecord::Migration[5.2]
  def change
    add_column :charges, :order_id, :integer, foreign_key: true,index:true
  end
end
