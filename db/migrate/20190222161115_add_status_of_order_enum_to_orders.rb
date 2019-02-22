class AddStatusOfOrderEnumToOrders < ActiveRecord::Migration[5.2]
	class Order < ApplicationRecord; end
	STATUS_TYPES = {'unsubmitted' => 0, 'needs_payment' => 1, 'needs_packing' => 2, 'needs_shipping' =>3, 'shipped' => 4}
  def change
    change_table(:orders) do |t|
      t.integer :status_of_order, default: 0 
    end

    reversible do |dir|
  	  Order.find_each do |order|
  	    dir.up do

  	  	  order.update(status_of_order: STATUS_TYPES[order.status])
  	    end
  	  end
    end
  end
end
