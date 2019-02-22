class AddDefaultShippingAddressToUsers < ActiveRecord::Migration[5.2]
  class User < ApplicationRecord; end
  def change
  	change_table(:users) do |t|
      t.integer :default_shiping_address, default: nil
      t.index [:default_shiping_address]
    end

    reversible do |dir|
  	  User.find_each do |user|
  	    dir.up do
  	  	  user.update(default_shiping_address: nil)
  	    end
  	  end
    end
  
  end
end
